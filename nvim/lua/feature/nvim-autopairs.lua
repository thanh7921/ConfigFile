local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup {
    -- NOTE: change ignore filetype when adding new plugin
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = false,  -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    disable_in_replace_mode = true,

    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

    enable_moveright = true,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true,  --- check bracket in same line
    enable_bracket_in_quote = true, -- auto pair bracket in quote '', "", ``
    enable_abbr = false, -- trigger abbreviation

    break_undo = false, -- action (insert) will be broken into multiple part, so require multiple undo
    check_ts = true, -- check and use treesitter

    map_cr = true, -- for auto indent within parentheses (), [], {}
    map_bs = true, -- map the <BS> key
    map_c_h = true, -- Map the <C-h> key to delete a pair
    map_c_w = true, -- map <c-w> to delete a pair if possible
}

-- Add spaces between parentheses
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
    Rule(' ', ' ')
        :with_pair(function (opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
                brackets[1][1]..brackets[1][2],
                brackets[2][1]..brackets[2][2],
                brackets[3][1]..brackets[3][2],
            }, pair)
        end)
}
for _,bracket in pairs(brackets) do
    npairs.add_rules {
        Rule(bracket[1]..' ', ' '..bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
                vim.pretty_print(opts)
                return opts.prev_char:match('.%'..bracket[2]) ~= nil
            end)
            :use_key(bracket[2])
    }
end
