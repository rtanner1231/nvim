
return {
    'rtanner1231/suiteqltools.nvim',
    dev=true,
    opts={
        sqlFormatter={
            keywordCase="upper",
            logicalOperatorNewline="after"
        },
        queryRun={
            editorKeymap={
                toggleWindow="<leader>sa",
                runQuery="<leader>sr",
                toggleResultZoom="<leader>sf",
                nextPage="<leader>sn",
                previousPage="<leader>sp",
                toggleDisplayMode="<leader>sm"
            },
            history=true
        }
    }
}
