return {
    {
        "theprimeagen/harpoon",
        config = function()
            require("harpoon").setup({})
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },
    { "mbbill/undotree" },
    {
        "roberte777/keep-it-secret.nvim",
        config = function()
            require("keep-it-secret").setup({
                wildcards = { ".*(.env)$", ".*(.secret)$" },
                enabled = false
            })
            vim.keymap.set(
                "n",
                "<leader>ks",
                ":lua require('keep-it-secret').toggle()<CR>",
                { noremap = true, silent = true }
            )
        end
    },
    {
        dir = vim.fn.stdpath('config') .. '/lua/adam/floating_terminal',
        name = 'floating_terminal_plugin',
        lazy = true,
        keys = {
            { '.', function() require('user.floating_terminal').toggle_terminal() end, desc = "Toggle Floating Terminal" },
        },
        config = function()
            vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>:lua require("user.floating_terminal").hide_terminal()<CR>', { noremap = true, silent = true })
        end,
    }
}
