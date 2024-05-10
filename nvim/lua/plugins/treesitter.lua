return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = { "c", "lua", "python", "rust", "query", "typescript", "javascript", "html"},
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
