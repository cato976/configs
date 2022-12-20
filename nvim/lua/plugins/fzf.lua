function FloatingFZF()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.fn.setbufvar(buf, '&signcolumn', 'no')

    local height = vim.fn.float2nr(50)
    local width = vim.fn.float2nr(280)
    local horizontal = vim.fn.float2nr((vim.inspect(vim.opt.columns._value) - width) / 2)
    local vertical = 1

    local opts = {
        relative = 'editor',
        row = vertical,
        col = horizontal,
        width = width,
        height = height,
        style = 'minimal'
    }

    vim.api.nvim_open_win(buf, true, opts)
end

vim.g["fzf_layout"] = { window = ':lua FloatingFZF()' }

--vim.api.nvim_command("command! -bang -nargs=? -complete=dir Files  call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always {}']}, <bang>0")

vim.cmd[[
    command! -bang -nargs=? -complete=dir Files  call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always {}']}, <bang>0)
]]
