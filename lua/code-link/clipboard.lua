local static = require("code-link.static")
local ClipBoard = {}

function ClipBoard.copy_or(content)
	if static.config == nil or static.config.copy_command == nil then
		return
	end

	local parsed_copy_command = static.config.copy_command(content)

	os.execute(parsed_copy_command)
end

return ClipBoard
