vim.o.laststatus = 3
vim.g.moonflyWinSeparator = 0

-- Customize Moonfly colors BEFORE loading the theme
require("moonfly").custom_colors({
	bg = "#000000",
	black = "#000000",
	white = "#FFFFFF",
	grey0 = "#4A2C3D",
})

-- Finally, apply the Moonfly colorscheme
vim.cmd.colorscheme("moonfly")

vim.lsp.enable({ "lua_ls" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local bufnr = event.buf
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

		if filetype == "" then
			return
		end

		local parser_name = vim.treesitter.language.get_lang(filetype)
		if not parser_name then
			return
		end
		local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
		if not parser_installed then
			return
		end

		local function map(lhs, rhs, opts)
			if lhs == "" then
				return
			end
			opts = vim.tbl_deep_extend("force", { silent = true }, opts or {})
			vim.keymap.set({ "v", "n" }, lhs, rhs, opts)
		end

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.treesitter.start()

		map("[c", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { buffer = bufnr, desc = "jump to TS context" })
		map("]f", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
		end, { buffer = bufnr, desc = "next function def" })
		map("[f", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
		end, { buffer = bufnr, desc = "prev function def" })
		map("]a", function()
			require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
		end, { buffer = bufnr, desc = "next param def" })
		map("[a", function()
			require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
		end, { buffer = bufnr, desc = "prev param def" })
		map("a]", function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end, { buffer = bufnr, desc = "swap next arg" })
		map("a[", function()
			require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
		end, { buffer = bufnr, desc = "swap prev arg" })
	end,
})
