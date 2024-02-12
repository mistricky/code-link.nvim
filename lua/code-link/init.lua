local CodeLink = require("code-link.link")
local static = require("code-link.static")
local table_utils = require("code-link.utils.table")
local main = {}

function main.setup(config)
	static.config = table_utils.merge(static.config, config)
end

function main.link()
	return CodeLink.new(static.config)
end

return main
