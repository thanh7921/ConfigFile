local options = {
    termguicolors = true,                    -- enable 24-bit tui color

    modeline = false,                        -- disable modeline

    showmode = false,                        -- don't show mode on bottom line, already have lualine for that
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    signcolumn = "yes",                      -- show signcolumn in the line number
    scrolloff = 5,                           -- keep n line below and above when scrolling

    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard (CTRL-C/V)

    undofile = true,                         -- enable persistent undo
    swapfile = true,                         -- creates a swapfile
    writebackup = true,                      -- create backup file when writting file to disk (delete afterward)

    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    smartcase = true,                        -- smart case
    wrapscan = false,                        -- no wrap back with searches

    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces used for each indentation
    softtabstop = 4,                         -- the number of spaces inserted when pressing tab
    autoindent = true,                       -- stupid auto indent by copying the last line indentation

    wrap = true,                             -- wrapping long line
    linebreak = true,                        -- line wrapped at 'breakat', no awkward break
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
