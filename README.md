<div>
  <p align="center"><img width=120 alt="code-link.nvim logo" src="https://raw.githubusercontent.com/mistricky/code-link.nvim/main/doc/code-link.svg"></p>
</div>
<p align="center">
  <b align="center">🔗 Code-link.nvim</b>
  <p align="center">Neovim plugin that make sharing code location easier written in Lua</p>

  
  
 <p align="center">
	 <img src="https://github.com/mistricky/code-link.nvim/actions/workflows/release.yml/badge.svg" /> 
  <img src="https://img.shields.io/github/v/release/mistricky/code-link.nvim" /> 
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" /> 
 </p>

</p>


https://github.com/mistricky/code-link.nvim/assets/22574136/e894d016-1829-419f-bb28-3db588edbd0c


## Installation
It is suggested to either use the latest release tag

Install with [Lazy.nvim](https://github.com/folke/lazy.nvim#-plugin-spec)
```lua
require("lazy").setup({
	"mistricky/code-link.nvim",
  -- ...
})
```

## Commands
There is only one command `CodeLink` you need to use, which allows you to create a share link by your origin address and branch name of the current git repository. And if you want to specify the branch name explicitly, just pass the branch name as args to the `CodeLink` command:
```shell
CodeLink branch_name # Create a share link with specific branch name

CodeLink # Create a share link with the current branch name
```

## Configuration
You can pass some configure items by the `setup` function, here is an example show you how to configure `code-link`:
```lua
require('code-link').setup({
  -- (Optional) Use value of the "origin" of git remote config by default
  origin = '...',

  -- (Optional) If the copy_command is passed, code-link will exec the copy_command after generated share link every time
  copy_command = function(link)
		return 'echo "' .. link .. '" | pbcopy'
	end,
})
```

## LICENSE
MIT.
