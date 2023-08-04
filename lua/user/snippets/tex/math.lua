local snippets, autosnippets = {}, {}

snippets = {

    -- \texttt
    s({trig="tt", dscr="Expands 'tt' into '\\texttt{}'"},
        fmta(
            "\\texttt{<>}",
            { i(1) }
        )
    ),

    -- \frac
    s({trig="ff", dscr="Expands 'ff' into '\\frac{}{}'"},
        fmt(
            "\\frac{<>}{<>}",
        {
            i(1),
            i(2)
        },
            {delimiters = "<>"} -- manually specifying angle bracket delimiters
        )
    ),
}

autosnippets = {

    -- [ GREEK LETTERS ] --

    -- Greek letter alpha.
    s({trig=";a"},
      {
        t("\\alpha"),
      }
    ),

    -- Greek letter beta.
    s({trig=";b"},
      {
        t("\\beta"),
      }
    ),

    -- Greek letter gamma.
    s({trig=";g"},
      {
        t("\\gamma"),
      }
    ),
}

return snippets, autosnippets
