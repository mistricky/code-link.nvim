local Selection = require("code-link.selection")
local command_util = require("code-link.utils.command")
local string_util = require("code-link.utils.string")
local CodeLink = {}

local function github_line(num)
	return "L" .. num
end

function CodeLink.new(config)
	local origin = CodeLink.get_git_origin(config)
    origin = CodeLink.convert_git_origin(origin)
	local branch_name = string_util.trim(command_util.exec_command("git branch --show-current", "r"))
	local instance = { branch_name = branch_name, origin = origin }

	setmetatable(instance, {
		__index = CodeLink,
	})

	return instance
end

-- @type origin string
function CodeLink.convert_git_origin(origin)
    origin = origin:gsub("%.git", "")
    return origin:gsub("git@([^:]+):([^/]+)/(.+)", "https://%1/%2/%3")
end

function CodeLink.get_git_origin(config)
	if config.origin ~= nil then
		return config.origin
	end

	local origin = string_util.trim(command_util.exec_command("git config --get remote.origin.url", "r"))

	return (string_util.ends_with(origin, "/") and origin:sub(1, -2) or origin) .. "/blob/"
end

function CodeLink.get_current_file_path()
    local full_file_path = vim.fn.expand("%:p")

    -- use this instead of cwd to account for files outside of root git directory
    local git_wd = string_util.trim(command_util.exec_command("git rev-parse --show-toplevel", "r"))

    return full_file_path:gsub(string_util.escape(git_wd), "")
end

function CodeLink.get_file_path_with_cwd()
	local full_file_path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()

	return full_file_path:gsub(string_util.escape(cwd), "")
end

function CodeLink.create_line_param(line_formatter, separator)
	local selection = Selection.new()

	return selection.line_start == selection.line_end and line_formatter(selection.line_start)
		or line_formatter(selection.line_start) .. separator .. line_formatter(selection.line_end)
end

function CodeLink:create_link(branch_name)
	local path = CodeLink.get_current_file_path()

	return self.origin
		.. (branch_name ~= "" and branch_name or self.branch_name)
		.. path
		.. "?plain=1#"
		.. CodeLink.create_line_param(github_line, "-")
end

return CodeLink
