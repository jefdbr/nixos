return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				nix = { "alejandra" },
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = {
			cmdline = { enabled = false },
			messages = { enabled = false },
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				ignored = false,
				hidden = false,
			},
		},
	},
}
