return {
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "moon",
			on_colors = function(colors)
				colors.bg = "#242424"
				colors.bg_dark = "#1e1e1e"
			end,
			on_highlights = function(hl, colors)
				hl.NeoTreeNormal = { fg = colors.fg, bg = "#242424" }
				hl.NeoTreeNormalNC = { fg = colors.fg, bg = "#242424" }
				hl.NeoTreeEndOfBuffer = { bg = "#242424" }
				hl.NormalFloat = { fg = colors.fg, bg = "#1e1e1e" }
				hl.FloatBorder = { fg = "#3d3846", bg = "#1e1e1e" }
				hl.FloatTitle = { fg = "#3584e4", bg = "#1e1e1e" }
				hl.LspInfoBorder = { fg = "#3d3846", bg = "#1e1e1e" }
				hl.WhichKeyNormal = { bg = "#1e1e1e" }
				hl.WhichKeyBorder = { fg = "#3d3846", bg = "#1e1e1e" }
				hl.WhichKeyTitle = { fg = "#3584e4", bg = "#1e1e1e" }
			end,
		},
	},
	{
		"LazyVim/LazyVim",
		opts = { colorscheme = "tokyonight-moon" },
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = {
					normal = {
						a = { bg = "#3584e4", fg = "#ffffff", gui = "bold" },
						b = { bg = "#2f334d", fg = "#c8d3f5" },
						c = { bg = "#242424", fg = "#888888" },
					},
					insert = {
						a = { bg = "#3584e4", fg = "#ffffff", gui = "bold" },
					},
					visual = {
						a = { bg = "#1b467c", fg = "#ffffff", gui = "bold" },
					},
					replace = {
						a = { bg = "#c01c28", fg = "#ffffff", gui = "bold" },
					},
					inactive = {
						a = { bg = "#242424", fg = "#3d3846" },
						b = { bg = "#242424", fg = "#3d3846" },
						c = { bg = "#242424", fg = "#3d3846" },
					},
				},
			},
		},
	},
}
