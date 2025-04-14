for _, plugin in ipairs({ "modus-themes.nvim", "lualine.nvim", "nvim-treesitter" }) do
	vim.cmd.packadd({ args = { plugin }, bang = true })
end

require("nvim-treesitter.configs").setup({
	sync_install = false,
	auto_install = false,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
})

require("lualine").setup({ options = { icons_enabled = true, theme = "modus-vivendi", globalstatus = true } })

vim.cmd([[colorscheme modus]])
