return {
	"conform.nvim",
	after = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "nixfmt" },
				haskell = { "ormolu" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
