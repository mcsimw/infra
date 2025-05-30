return {
	{
		"nvim-treesitter",
		after = function()
			require("nvim-treesitter.configs").setup({
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"rainbow-delimiters.nvim",
		after = function()
			local highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			}
			vim.g.rainbow_delimiters = {
				highlight = highlight,
			}
		end,
	},
}
