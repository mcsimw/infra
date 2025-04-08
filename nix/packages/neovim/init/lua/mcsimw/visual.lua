vim.cmd([[colorscheme modus]])

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "modus-vivendi",
		globalstatus = true,
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
