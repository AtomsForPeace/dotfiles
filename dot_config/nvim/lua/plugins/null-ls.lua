return {
    -- Add the null-ls plugin
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})

            -- Set up null-ls with Ruff as the formatter
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.ruff, -- Linting with Ruff
                    null_ls.builtins.formatting.black, -- Formatting with Black
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = lsp_formatting_group, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = lsp_formatting_group,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
