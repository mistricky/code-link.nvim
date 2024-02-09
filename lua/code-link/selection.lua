local Selection = {}

local function wrap_selection_value(value)
	return value, value
end

local function get_selection()
	local line_start = vim.fn.line("'<")
	local line_end = vim.fn.line("'>")

	if line_start == line_end then
		local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))

		return wrap_selection_value(row)
	end

	return line_start, line_end
end

function Selection.new()
	local line_start, line_end = get_selection()
	local instance = { line_start = line_start, line_end = line_end }

	setmetatable(instance, {
		__index = Selection,
	})

	return instance
end

return Selection
