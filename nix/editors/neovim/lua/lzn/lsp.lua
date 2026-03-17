return {
	{
		"nvim-lspconfig",
		lazy = false,
		after = function()
			vim.lsp.enable({ "hls", "lua_ls", "tinymist", "clangd", "nixd", "qmlls" })
		end,
	},
}
