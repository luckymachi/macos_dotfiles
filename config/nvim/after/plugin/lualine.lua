local lualine = require("lualine")

local colors = {
	bg = "#212436",
	black = "#414868",
	red = "#f7768e",
	green = "#62d196",
	yellow = "#e0af68",
	blue = "#7aa2f7",
	purple = "#be95ff",
	aqua = "#7dcfff",
	white = "#c0caf5",
}

local custom_tokyo_night = require("lualine.themes.auto")
custom_tokyo_night.normal = {
	a = { bg = colors.bg, fg = colors.blue, gui = "bold" },
	b = { bg = colors.bg, fg = colors.blue, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
custom_tokyo_night.insert = {
	a = { bg = colors.bg, fg = colors.green, gui = "bold" },
	b = { bg = colors.bg, fg = colors.green, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
custom_tokyo_night.visual = {
	a = { bg = colors.bg, fg = colors.purple, gui = "bold" },
	b = { bg = colors.bg, fg = colors.purple, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
custom_tokyo_night.replace = {
	a = { bg = colors.bg, fg = colors.yellow, gui = "bold" },
	b = { bg = colors.bg, fg = colors.yellow, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
custom_tokyo_night.command = {
	a = { bg = colors.bg, fg = colors.aqua, gui = "bold" },
	b = { bg = colors.bg, fg = colors.aqua, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
custom_tokyo_night.inactive = {
	a = { bg = colors.bg, fg = colors.white, gui = "bold" },
	b = { bg = colors.bg, fg = colors.white, gui = "bold" },
	c = { bg = colors.bg, fg = colors.white, gui = "bold" },
}
lualine.setup({
	opt = true,
	options = {
		theme = custom_tokyo_night, -- keep your current theme
		globalstatus = true,
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
	},
	sections = {
		-- Or, added to the default lualine_b config from here: https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#default-configuration
		lualine_b = { "branch", "diff", "diagnostics", "spelunk" },
		lualine_x = { "filetype" },
		lualine_y = {},
	},
})
