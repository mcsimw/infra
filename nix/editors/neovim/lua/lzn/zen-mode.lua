return {
	"zen-mode.nvim",
	cmd = "ZenMode",
	keys = {
		{
			"<leader>z",
			function()
				require("zen-mode").toggle({})
			end,
			desc = "Toggle [Z]en",
			mode = "n",
		},
	},
}
