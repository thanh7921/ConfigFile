-- the order of initialization should be as followed
-- 1. mason
-- 2. mason-lspconfig
-- 3. lspconfig (from plugin nvim-lspconfig)
-- recommended from the mason-lspconfig guide
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

-- get list of languager server to install (reference the nvim-lspconfig doc for name)
local lslist = require("lsp.server-list")

require("mason-lspconfig").setup {
    ensure_installed = lslist,
    automatic_installation = true,
}

-- generic keymap (for all lang server)
require("lsp.generic.keymaps")

-- get generic option for each server
local generic_lsp_options = {
    on_attach = require("lsp.generic.on_attach"),
    flags = require("lsp.generic.flags"),
    capabilities = require("lsp.generic.capabilities")
}

-- configure each lang server through nvim-lspconfig plugin
local lspconfig = require("lspconfig")

for _, server in pairs(lslist) do
    -- get only the name of each server
    server = vim.split(server, "@")[1]

    local specific_lsp_options_loaded, specific_lsp_options = pcall(require, "lsp.specific." .. server)
    if specific_lsp_options_loaded then
        specific_lsp_options = vim.tbl_deep_extend("force", generic_lsp_options, specific_lsp_options)
        lspconfig[server].setup(specific_lsp_options)
    else
        lspconfig[server].setup(generic_lsp_options)
    end
end

-- configure function related to LSP (signcolumn, diagnostic, LSP handler, ...)
require("lsp.config")
