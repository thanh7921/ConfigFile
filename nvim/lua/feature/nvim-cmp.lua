-- Set up nvim-cmp.
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 60
local MIN_LABEL_WIDTH = 40

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'buffer', keyword_length = 4 },
        { name = 'path' },
    }),

    -- limit the drop down to constant character width
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only text then symbol annotations
            maxwidth = MAX_LABEL_WIDTH, -- prevent popup from showing more than the limit
            ellipsis_char = ELLIPSIS_CHAR, -- if lable too long, replaced extended part with ellipsis_char

            -- The function below will be called before any actual modifications from lspkind
            -- It will pad the label so that the resulting string is MIN_LABEL_WIDTH long
            before = function (_, vim_item)
                local label = vim_item.abbr
                if string.len(label) < MIN_LABEL_WIDTH then
                    local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                    vim_item.abbr = label .. padding
                end
                return vim_item
            end,
            menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buff]",
                path = "[Path]"
            },
        }),
    },
    experimental = {
        ghost_text = true,
    }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

-- If you want to insert `(` after select function or method item
cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
)
