local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
    function(use)
        -- PACKAGE MANAGER AND FAST LOAD --
        --------------------------------------------------------------------------
        use 'wbthomason/packer.nvim'
        use 'lewis6991/impatient.nvim'

        -- COLOR SCHEME --
        --------------------------------------------------------------------------
        use 'folke/tokyonight.nvim'
        use 'sainnhe/sonokai'
        use 'shaunsingh/nord.nvim'
        use 'navarasu/onedark.nvim'

        -- LUALINE --
        --------------------------------------------------------------------------
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons' }
        }

        -- INDENT GUIDE --
        --------------------------------------------------------------------------
        use "lukas-reineke/indent-blankline.nvim"

        -- DASHBOARD--
        --------------------------------------------------------------------------
        -- use 'glepnir/dashboard-nvim'

        -- TREESITTER --
        --------------------------------------------------------------------------
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        }

        -- LSP --
        --------------------------------------------------------------------------
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "onsails/lspkind.nvim",
        }

        -- AUTOPAIR --
        --------------------------------------------------------------------------
        use "windwp/nvim-autopairs"

        -- COMMENT--
        --------------------------------------------------------------------------
        use "numToStr/Comment.nvim"

        -- COMPLETION--
        --------------------------------------------------------------------------
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",

                "kyazdani42/nvim-web-devicons",
                "onsails/lspkind.nvim",
            },
        }

        -- SNIPPET --
        --------------------------------------------------------------------------
        use {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip" -- for snippet integration into nvim-cmp
        }

        -- Automatically set up your configuration after cloning packer.nvim
        if packer_bootstrap then
            require('packer').sync()
        end
        -- Add autocommand for PackerSync after this file is changed
        vim.cmd([[
            augroup packer_user_config
                autocmd!
                autocmd BufWritePost packer.lua source <afile> | PackerSync
            augroup end
        ]])
    end,

    config = {
        -- display packer in a window
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
