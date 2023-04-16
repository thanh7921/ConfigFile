-- USER OPTION --
require('user.options')
require('user.keymaps')

-- PLUGIN --
require('plugin')       -- have init.lua to load other plugin

-- LSP --
require('lsp')          -- have init.lua to load other plugin

-- FEATURE --
require('feature.treesitter')
require('feature.indent-blankline')
require('feature.nvim-autopairs')
require('feature.comment')
require('feature.luasnip')
require('feature.nvim-cmp')

-- UI CHANGES --
-- put setting the colorscheme first, so that other plugin see the new color scheme
require('ui.colorscheme.nord')
require('ui.lualine')
-- require('ui.dashboard')
