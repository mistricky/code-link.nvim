local CodeLink = require("code-link.link")
local static = require("code-link.static")
local main = {}

function main.setup(config)
	static.config = config
end

function main.link()
	return CodeLink.new(static.config)
end

return main
