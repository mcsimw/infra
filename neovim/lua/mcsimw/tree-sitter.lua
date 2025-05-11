---@dignostic disable: missing-fields
require("nvim-treesitter.configs").setup({
	-- ignore_install = { "all" },
	highlight = {
		enable = true,
		disable = { "bigfile" },
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Conflicts with treesitter
vim.opt.smartindent = false
