require("indent_blankline").setup {
    filetype_exclude = { "dashboard", "help"},
    -- blank line will have different indent guide
    char_blankline = '┊',    -- set to serated indent guide

    -- show context
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_current_context_start_on_current_line = true,
    context_char = '┃'
}
