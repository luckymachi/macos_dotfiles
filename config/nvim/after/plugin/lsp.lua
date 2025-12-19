-- LSP
local lsp = vim.lsp

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("<leader>r", vim.lsp.buf.rename)
	bufmap("<leader>a", vim.lsp.buf.code_action)

	bufmap("gd", function()
		vim.cmd.split()
		vim.lsp.buf.definition()
	end)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("gI", vim.lsp.buf.implementation)
	bufmap("<leader>D", vim.lsp.buf.type_definition)

	--bufmap("gr", require("telescope.builtin").lsp_references)
	--bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
	--bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

	bufmap("<leader>h", vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local util = require("lspconfig/util")

require("neodev").setup()

require("lspconfig").clangd.setup({})

require("lspconfig").gopls.setup({
	cmd = { "gopls" },
	on_attach = on_attach,
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
			workspaceFolders = true,
		},
	},
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

require("lspconfig").zls.setup({})

lsp.handlers["textdocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

-- bordered lsp diagnostics
vim.diagnostic.config({
	float = { border = "rounded" },
})

vim.filetype.add({ extension = { typ = "typst" } })
require("lspconfig").tinymist.setup({
	capabilities = capabilities,
	single_file_support = true,
	root_dir = function(filename, bufnr)
		return vim.fn.getcwd()
	end,
	-- pin the main file
	--	vim.lsp.buf.execute_command({ command = "tinymist.pinMain", arguments = { vim.api.nvim_buf_get_name(0) } }),
	-- unpin the main file
	--vim.lsp.buf.execute_command({ command = "tinymist.pinMain", arguments = { nil } }),
	settings = {
		exportPdf = "onSave",
		systemFonts = true,
		--formatterMode = "typstyle",
	},
})

-- lspconfig.ts_ls.setup {}
--[[
require("lspconfig").volar.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})
]]

require("lspconfig").ty.setup({
	settings = {
		-- ty language server settings go here
		ty = {
			cmd = { "ty", "server" },
			filetypes = { "python", "py" },
			root_dir = vim.fs.root(0, { ".git/", "pyproject.toml" }),
		},
	},
})
vim.lsp.enable("ty")

--[[
require("lspconfig").ruby_lsp.setup({
	capabilities = capabilities,
})
]]
