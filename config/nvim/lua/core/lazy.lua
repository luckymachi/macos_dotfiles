-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
	-- Barbecue + dependencies
	--[[
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		opts = {},
	},
	]]
	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		opt = true,
	},
	-- Oil
	"stevearc/oil.nvim",
	-- LSP + dependencies
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"folke/neodev.nvim",
		},
	},
	-- CMP + dependencies
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
	},
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	-- Treesitter + dependencies
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	"windwp/nvim-ts-autotag",
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "OXY2DEV/markview.nvim" },
		lazy = false,
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSUpdate" },
		event = { "BufRead", "BufNewFile" },
		build = function()
			vim.cmd("TSUpdate")
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- For `nvim-treesitter` users.
		priority = 49,

		-- For blink.cmp's completion
		-- source
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
	},
	-- No-neck-pain
	{ "shortcuts/no-neck-pain.nvim", version = "*" },
	-- Conform
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
	},
	-- Rustacean
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		ft = { "rust" },
	},
	-- todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufNewFile", "BufReadPost" },
		keys = {
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment (Todo)",
			},
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment (Todo)",
			},
			{
				"<leader>xt",
				function()
					vim.cmd.Trouble("todo toggle focus=true filter = {tag = {FIX,TODO,HACK,WARN}}")
				end,
				desc = "Todo actionable comments (Trouble)",
			},
			{
				"<leader>xT",
				function()
					vim.cmd.Trouble("todo toggle focus=true")
				end,
				desc = "Todo all comments (Trouble)",
			},
		},
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- trouble.nvim
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	-- Typst
	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
	},
	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "night",
			transparent = true,
			on_colors = function(colors)
				colors.green = "#62d196"
				colors.comment = "#86a1db"
				colors.gitSigns = {
					add = "#62d196",
					change = "#7dcfff",
					delete = "#f7768e",
				}
			end,
			styles = {
				floats = "transparent",
				sidebars = "transparent",
				comments = { italic = false },
				keywords = { italic = false },
			},
		},
	},
	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {},
	},
	-- Devicons
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			override_by_extension = {
				lua = {
					icon = "󰢱",
					color = "#4d5beb",
					--color = "#003ab8",
					name = "Lua",
				},
				rs = {
					icon = "",
					color = "#ff9e64",
					--color = "#ff832b",
					name = "Rust",
				},
				rb = {
					icon = "",
					color = "#f7768e",
					name = "Ruby",
				},
				py = {
					icon = "",
					color = "#6fdc8c",
					name = "Python",
				},
				go = {
					icon = "",
					color = "#7dcfff",
					name = "Go",
				},
				["go.mod"] = {
					icon = "",
					color = "#6fdc8c",
					name = "GoMod",
				},
				["go.sum"] = {
					icon = "",
					color = "#f7768c",
					name = "GoSum",
				},
				cpp = {
					icon = "",
					color = "#5e99ff",
					name = "CPP",
				},
				c = {
					icon = "",
					color = "#BB9AF7",
					--color = "#6929c4",
					name = "C",
				},
				tex = {
					icon = "",
					color = "#c0caf5",
					name = "LaTeX",
				},
				md = {
					icon = "󰽛",
					color = "#c0caf5",
					name = "Markdown",
				},
				vim = {
					icon = "",
					color = "#6fdc8c",
					name = "Vim",
				},
				vue = {
					icon = "",
					color = "#62d196", --#289c5e
					name = "Vue",
				},
				nix = {
					icon = "",
					color = "#33b1ff",
					name = "Nix",
				},
				ts = {
					icon = "",
					color = "#6bb8ff", --5e99ff
					name = "Typescript",
				},
				js = {
					icon = "",
					color = "#ffd12b",
					name = "Javascript",
				},
				["tsx"] = {
					icon = "󰜈",
					color = "#6fb8fc",
					name = "Tsx",
				},
				["norg"] = {
					icon = "",
					color = "#3692d5",
					name = "Neorg",
				},
				["nuxt.config.ts"] = {
					icon = "󱄆",
					color = "#289c5e",
					name = "Nuxt",
				},
				["Cargo.toml"] = {
					icon = "",
					color = "#ff9e64",
					name = "Cargo.toml",
				},
				["gleam"] = {
					icon = "",
					color = "#ff96f3",
					name = "Gleam",
				},
				["typ"] = {
					icon = "",
					color = "#6fdcbb",
					name = "Typst",
				},
				["slint"] = {
					icon = "󱐌",
					color = "#5e99ff",
					name = "Slint",
				},
			},
		},
	},
	-- ruby.lsp
	{
		"adam12/ruby-lsp.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = true,
		opts = {
			auto_install = false,
			lspconfig = {
				init_options = {
					formatter = "standard",
					linters = { "standard" },
				},
			},
		},
	},
	-- Dropbar
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	-- Cord
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
	},
})
