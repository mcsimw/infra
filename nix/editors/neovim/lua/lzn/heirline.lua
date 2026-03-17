return {
	"mini.statusline",
	lazy = false,
	before = function()
		LZN.trigger_load("mini.icons")
	end,
	after = function()
		require("mini.statusline").setup()
	end,
}
