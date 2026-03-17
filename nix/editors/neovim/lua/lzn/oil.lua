return {
	"oil.nvim",
	lazy = vim.fn.argc(-1) == 0,
	before = function()
		require("lz.n").trigger_load("mini.icons")
	end,
	after = function()
		require("oil").setup({
			default_file_explorer = true,
			keymaps = {
				["<C-c>"] = false,
				["<leader>o"] = "actions.close",
			},
			view_options = {
				show_hidden = true,
			},
		})
	end,
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open Parent Directory in Oil" },
	},
}
