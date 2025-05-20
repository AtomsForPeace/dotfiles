-- ~/.config/nvim/lua/adam/floating_terminal/init.lua

local M = {}

M.terminal_buf = nil
M.terminal_win = nil
M.hidden = true

function M.toggle_terminal()
    if M.hidden then
        M.show_terminal()
    else
        M.hide_terminal()
    end
end

function M.show_terminal(opts)
    opts = opts or {}
    if M.terminal_buf == nil or not vim.api.nvim_buf_is_valid(M.terminal_buf) then
        -- 1. Create a new scratch buffer (this ID might become invalid soon)
        M.terminal_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(M.terminal_buf, 'bufhidden', 'wipe')
        vim.api.nvim_buf_set_name(M.terminal_buf, '[floating-terminal]')

        -- 2. CRUCIAL: Temporarily make our initial buffer the current buffer
        local old_current_buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_set_current_buf(M.terminal_buf)

        -- 3. Call vim.cmd.terminal(). This command will create/activate the terminal.
        -- It might internally create a *new* buffer and replace the one we just created.
        vim.cmd.terminal()

        -- 4. NEW CRITICAL STEP: Get the *actual* ID of the terminal buffer after vim.cmd.terminal()
        -- This new ID is the one that's valid and refers to the running terminal.
        M.terminal_buf = vim.api.nvim_get_current_buf()

        -- 5. Restore the original current buffer
        vim.api.nvim_set_current_buf(old_current_buf)

        -- 6. Set buffer-local keymaps for the terminal mode using the *new*, valid ID.
        vim.keymap.set(
            't', -- Mode: terminal insert mode
            '<C-space>', -- Key: Control+Space
            '<C-\\><C-N>:lua require("adam.floating_terminal").toggle_terminal()<CR>', -- Action: Exit terminal insert mode, then toggle
            { desc = "Toggle Floating Terminal", buffer = M.terminal_buf } -- Options: description, buffer-local
        )

        vim.keymap.set(
            't',
            '<esc>',
            '<C-\\><C-N>:lua require("adam.floating_terminal").hide_terminal()<CR>',
            { desc = "Hide Floating Terminal (Esc)", buffer = M.terminal_buf }
        )
    end

    -- 7. Now, open the floating window to *display* the already initialized terminal buffer (using its valid ID).
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        border = 'rounded',
        style = 'minimal',
    }

    M.terminal_win = vim.api.nvim_open_win(M.terminal_buf, true, opts)

    -- 8. Set window-specific options for the floating terminal.
    vim.api.nvim_win_set_option(M.terminal_win, 'winhl', 'Normal:Normal,FloatBorder:FloatBorder')
    vim.api.nvim_win_set_option(M.terminal_win, 'cursorline', false)
    vim.api.nvim_win_set_option(M.terminal_win, 'number', false)
    vim.api.nvim_win_set_option(M.terminal_win, 'relativenumber', false)
    vim.api.nvim_win_set_option(M.terminal_win, 'foldenable', false)
    vim.api.nvim_win_set_option(M.terminal_win, 'signcolumn', 'no')
    vim.api.nvim_win_set_option(M.terminal_win, 'wrap', false)

    -- 9. Enter terminal insert mode immediately.
    vim.cmd('startinsert')
    M.hidden = false
end

function M.hide_terminal()
    if M.terminal_win and vim.api.nvim_win_is_valid(M.terminal_win) then
        vim.api.nvim_win_hide(M.terminal_win)
        M.hidden = true
        -- Return focus to the previous window
        vim.api.nvim_set_current_win(vim.api.nvim_get_current_win())
    end
end

return M
