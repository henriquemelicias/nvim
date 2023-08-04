local snippets, autosnippets = {}, {}

snippets = {

    s({trig="hr", dscr="The hyperref package's href{}{} command (for url links)"},
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "display name"),
            }
        )
    ),
}

autosnippets = {}

return snippets, autosnippets
