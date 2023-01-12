local snippets, autosnippets = {}, {}

snippets = {
    -- Equation.
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
    --Generic environment.
    s({trig="env"},
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1),  -- this node repeats insert node i(1)
            }
        )
    ),

}

return snippets, autosnippets
