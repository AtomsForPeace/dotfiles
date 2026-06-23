return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        -- tree-sitter CLI 0.26+ removed the `--no-bindings` flag (generate no
        -- longer emits bindings). nvim-treesitter's frozen `master` branch still
        -- passes it, breaking parser generation (e.g. swift). Pre-set the args so
        -- the plugin skips its own (broken) computation. Survives plugin updates.
        require("nvim-treesitter.install").ts_generate_args = {
            "generate", "--abi", vim.treesitter.language_version,
        }

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "lua", "python", "rust", "query",
                "typescript", "javascript", "html",
                "elixir", "heex", "eex",
            },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
