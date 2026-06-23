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
        dir = '~/ProReNata/shapedown.nvim',
        dev = true,
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
          require('shapedown').setup()
          vim.keymap.set('n', '<leader>so', '<cmd>Shapedown<cr>',         { desc = 'Shapedown: open picker' })
          vim.keymap.set('n', '<leader>sn', '<cmd>Shapedown new<cr>',     { desc = 'Shapedown: new document' })
          vim.keymap.set('n', '<leader>sp', '<cmd>Shapedown project<cr>', { desc = 'Shapedown: project picker' })
          vim.keymap.set('n', '<leader>sr', '<cmd>Shapedown reload<cr>',  { desc = 'Shapedown: reload buffer' })
        end,
      }
}
