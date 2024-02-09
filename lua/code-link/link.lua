local Selection = require("code-link.selection")
local command_util = require("code-link.utils.command")
local string_util = require("code-link.utils.string")
local CodeLink = {}

local function line(num)
	return "L" .. num
end

function CodeLink.new()
	local instance = {}

	setmetatable(instance, {
		__index = CodeLink,
	})

	return instance
end

function CodeLink:get_git_origin(config)
	if not config.origin == nil then
		self.origin = config.origin
		return
	end

	local origin = string_util.trim(command_util.exec_command("git config --get remote.origin.url", "r"))

	self.origin = string_util.ends_with(origin, "/") and origin:sub(1, -2) or origin
end

function CodeLink.get_current_file_path()
	local full_file_path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()

	return full_file_path:gsub(string_util.escape(cwd), "")
end

function CodeLink:create_line_param()
	local selection = Selection.new()

	return selection.line_start == selection.line_end and line(selection.line_start)
		or line(selection.line_start) .. "-" .. line(selection.line_end)
end

function CodeLink:create_link()
	self.branch_name = string_util.trim(command_util.exec_command("git branch --show-current", "r"))

	local path = CodeLink.get_current_file_path()

	return self.origin .. "/blob/" .. self.branch_name .. path .. "?plain=1#" .. CodeLink:create_line_param()
end

return CodeLink
