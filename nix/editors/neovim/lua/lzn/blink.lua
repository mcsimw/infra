return {
	{
		"lspkind.nvim",
	},
	{
		"blink.cmp",
		event = "DeferredUIEnter",
		before = function()
			local lzn = require("lz.n")
			lzn.trigger_load("lazydev.nvim")
			lzn.trigger_load("lspkind.nvim")
			lzn.trigger_load("mini.icons")
		end,
		after = function()
			local blink = require("blink.cmp")
			blink.setup({
				signature = {
					enabled = true,
				},
				completion = {
					ghost_text = {
						enabled = true,
					},
					menu = {
						draw = {
							components = {
								kind_icon = {
									text = function(ctx)
										if ctx.source_name ~= "path" then
											return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
										end

										-- Path source → mini.icons
										if not ctx.item.data then
											return ctx.kind_icon .. ctx.icon_gap
										end
										local icon = select(1, require("mini.icons").get(ctx.item.data.type, ctx.label))
										return (icon or ctx.kind_icon) .. ctx.icon_gap
									end,
									highlight = function(ctx)
										if ctx.source_name ~= "path" then
											return ctx.kind_hl
										end

										if not ctx.item.data then
											return ctx.kind_hl
										end

										local _, hl = require("mini.icons").get(ctx.item.data.type, ctx.label)

										return hl or ctx.kind_hl
									end,
								},
							},
						},
					},
					list = {
						selection = {
							preselect = false,
							auto_insert = false,
						},
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
				},
				sources = {
					default = {
						"lazydev",
						"lsp",
						"buffer",
						"snippets",
						"path",
						"omni",
					},
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				},
				fuzzy = {
					implementation = "rust",
				},
			})
		end,
	},
}
