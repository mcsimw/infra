vim.o.laststatus = 3
vim.g.moonflyWinSeparator = 0

-- Customize Moonfly colors BEFORE loading the theme
require("moonfly").custom_colors({
	bg = "#000000",
	black = "#000000",
	white = "#FFFFFF",
})

-- Finally, apply the Moonfly colorscheme
vim.cmd.colorscheme("moonfly")
