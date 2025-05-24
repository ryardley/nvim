return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = "v0.0.23", -- Never set this value to "*"! Never!
	opts = {
		provider = "claude",
		auto_suggestions_provider = "claude",
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-5-sonnet-20241022",
			timeout = 30000, -- Timeout in milliseconds
			temperature = 0,
			max_tokens = 8192,
			disable_tools = true, -- disable tools!
		},
		behaviour = {
			auto_suggestions = false,
			minimize_diff = false,
			enable_cursor_planning_mode = true,
			enable_claude_text_editor_tool_mode = true,
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
