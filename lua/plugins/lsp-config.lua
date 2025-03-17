-- Require necessary modules
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local mason_tool_installer = require('mason-tool-installer')
local cmp = require("cmp")

-- Set up Mason to manage LSP servers
mason.setup()

-- Define LSP servers to install
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",  -- Lua LSP
        "pylsp",   -- Python LSP
        "clangd",  -- C/C++ LSP
		"cssls", --CSS
		"html", --HTML
    },
})

mason_tool_installer.setup({
	-- Non-LSP tools to install automatically
	ensure_installed = {
		'prettier',
		'isort',
	}
})

-- Set up nvim-cmp for autocompletion
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),  -- Next suggestion
        ['<C-p>'] = cmp.mapping.select_prev_item(),  -- Previous suggestion
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),  -- Accept suggestion
        ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
    }),
    sources = {
        { name = 'nvim_lsp' },  -- LSP completions
        { name = 'buffer' },    -- Buffer completions
    },
})

-- Enhance LSP capabilities with autocompletion support
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configure LSP servers
mason_lspconfig.setup_handlers({
    -- Default handler for all servers
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
        })
    end,
    -- Specific configuration for lua_ls
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "Lua 5.1" },  -- Match Neovim's Lua version
                    diagnostics = { globals = { 'vim' } },  -- Recognize 'vim' global
                }
            }
        })
    end,
	-- Specific configuration for pylsp (Python)
    ["pylsp"] = function()
        lspconfig.pylsp.setup({
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = { enabled = true },  -- Linting with pycodestyle
                        pyflakes = { enabled = true },     -- Linting with pyflakes
                        pylint = { enabled = false },      -- Disable pylint (optional, enable if installed)
                        jedi_completion = { enabled = true }, -- Autocompletion
                        jedi_hover = { enabled = true },   -- Hover info
                        jedi_references = { enabled = true }, -- Find references
                        jedi_signature_help = { enabled = true }, -- Signature help
                        mccabe = { enabled = false },      -- Disable complexity checker (optional)
                        preload = { enabled = true },      -- Preload modules for better completion
                        rope_completion = { enabled = false }, -- Disable rope (slower alternative to jedi)
                    }
                }
            },
            root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", ".git"), -- Project root detection
        })
    end,
})

-- Set up keybindings when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        -- Hover documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Show hover documentation' }))
        -- Go to definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
        -- Go to declaration
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
        -- Telescope LSP integrations
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<cr>', vim.tbl_extend('force', opts, { desc = 'Show LSP references' }))
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', vim.tbl_extend('force', opts, { desc = 'Show LSP implementations' }))
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', vim.tbl_extend('force', opts, { desc = 'Show LSP type definitions' }))
    end,
})
