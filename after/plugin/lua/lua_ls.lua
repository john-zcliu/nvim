-- ~/.config/nvim/after/plugin/lua_ls.lua (Updated method)

local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = require("plugins.lsp").on_attach -- Make sure this is still fixed!

-- Use vim.lsp.config to directly set the configuration for the server
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } }, -- The crucial setting
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
})
