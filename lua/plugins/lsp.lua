return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        -- 1. CAPABILITIES & DEFAULTS
        --------------------------------------------------
        -- Enhance LSP capabilities for nvim-cmp
        local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities()
        )

        -- 2. LSP ATTACH AUTOCMD & KEYMAPS
        --------------------------------------------------

        -- Function to set up keymaps on LSP attachment
        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            -- Auto-formatting on save (only if the client supports it)
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({
                            formatting_options = { tabSize = 4, insertSpaces = true },
                            bufnr = bufnr,
                        })
                    end
                })
            end

            -- Keymaps for LSP functionality
            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end

        -- 3. DIAGNOSTIC & UI CONFIG
        --------------------------------------------------

        -- Add borders to floating windows
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
        )
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )

        -- Configure error/warnings interface
        vim.diagnostic.config({
            virtual_text = true,
            severity_sort = true,
            float = {
                style = 'minimal',
                border = 'rounded',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN] = '▲',
                    [vim.diagnostic.severity.HINT] = '⚑',
                    [vim.diagnostic.severity.INFO] = '»',
                },
            },
        })

        -- 4. MASON AND LSP SETUP (THE CRITICAL PART)
        --------------------------------------------------

        require('mason').setup({})

        -- Use setup_handlers to configure all installed LSPs
        require('mason-lspconfig').setup {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "ts_ls",
                "intelephense",
            },
            handlers = {
                -- Default Handler: Sets up all LSPs with the base config
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                -- Custom Handler: lua_ls (Overrides default config with specific settings)
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
				runtime = {
				    -- Tell the language server which version of Lua you're using
				    -- (most likely LuaJIT in the case of Neovim)
				    version = 'LuaJIT',
				  },
				  diagnostics = {
				    -- Get the language server to recognize the `vim` global
				    globals = {
				      'vim',
				      'require'
				    },
				  },
				  workspace = {
				    -- Make the server aware of Neovim runtime files
				    library = vim.api.nvim_get_runtime_file("", true),
				  },
				  -- Do not send telemetry data containing a randomized but unique identifier
				  telemetry = {
				    enable = false,
				  },
                            },
                        },
                    })
                end,
            },
        }

        -- 5. CMP (AUTOCOMPLETION) SETUP
        --------------------------------------------------

        require('luasnip.loaders.from_vscode').lazy_load()
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == 'nvim_lsp' then
                        item.menu = '[LSP]'
                    else
                        item.menu = string.format('[%s]', n)
                    end
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- confirm completion item
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- scroll documentation window
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),

                -- tab complete
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = 'select' })
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),

                -- go to previous item
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),

                -- navigate to next snippet placeholder
                ['<C-d>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- navigate to the previous snippet placeholder
                ['<C-b>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })
    end
}
