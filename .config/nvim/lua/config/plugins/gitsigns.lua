-- Gitsigns
-- See `:help gitsigns.txt`
--require('gitsigns').setup {
return {
    "lewis6991/gitsigns.nvim",
    name = "gitsigns",
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
    }
}
