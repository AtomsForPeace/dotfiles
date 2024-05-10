return {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
        require("tokyonight").setup({
            disable_background = true
        })
        vim.cmd [[colorscheme tokyonight]]
    end
}
