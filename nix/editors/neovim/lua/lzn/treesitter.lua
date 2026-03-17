return {
	"nvim-treesitter",
	event = { "BufNewFile", "BufReadPost", "BufWritePost", "DeferredUIEnter" },
	lazy = vim.fn.argc(-1) == 0,
	after = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				pcall(vim.treesitter.start, ev.buf)
			end,
		})
	end,
}
