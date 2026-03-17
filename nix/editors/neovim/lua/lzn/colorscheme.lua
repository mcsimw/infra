return {
	"vim-moonfly-colors",
	lazy = false,
	priority = 1000,
	after = function()
		vim.g.moonflyWinSeparator = 2
		require("moonfly").custom_colors({
			bg = "#000000",
		})
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "moonfly",
			callback = function()
				vim.api.nvim_set_hl(0, "NormalNC", { bg = "#080808" })
			end,
		})
		vim.cmd.colorscheme("moonfly")
	end,
}
