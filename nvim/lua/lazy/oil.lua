return {
	"oil.nvim",
	lazy = false,
	after = function()
		require("oil").setup({
			keymaps = {
				["<C-c>"] = false,
				["<leader>o"] = "actions.close",
			},
		})
	end,
}
