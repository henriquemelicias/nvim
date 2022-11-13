local snippets, autosnippets = {}, {}

snippets = {

    -- Equation
    s({trig="eq", dscr="Expands 'eq' into an equation environment"},
        fmta(
                [[
                    \begin{equation*}
                       <>
                    \end{equation*}
                ]],
            { i(1) }
        )
    )
}

autosnippets = {
}

return snippets, autosnippets
