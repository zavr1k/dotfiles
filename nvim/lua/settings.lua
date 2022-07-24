local cmd = vim.cmd
local opt = vim.opt
local g = vim.g


g.mapleader = ','

opt.colorcolumn = '80'
opt.cursorline = true
opt.number = true
opt.splitright = true
opt.splitbelow = true
opt.mouse = 'a'


opt.termguicolors = true
cmd'colorscheme onedark'

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true


-----------------------------------------------------------
-- Установки для плагинов
-----------------------------------------------------------
-- lsp settings
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = function() 
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.definition, {buffer = 0})
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer = 0})
            vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {buffer = 0})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
    }
    server:setup(opts)
end)

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- Шорткаты не работают
    mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
    ['<C-n>'] = cmp.mapping({
    c = function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
    end,
    i = function(fallback)
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end
    }),
    ['<C-p>'] = cmp.mapping({
    c = function()
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
    end,
    i = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer'
        -- , option = {
        --     get_bufnrs = function()
        --         return vim.api.nvim_list_bufs()
        --     end
        --     },
        },
    },
}
