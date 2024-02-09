local code_link = require("code-link")

vim.api.nvim_create_user_command("CodeLink", function()
	local link = code_link.link()

	link:get_git_origin({})

	local generated_link = link:create_link()

	vim.notify(generated_link)
end, {})
