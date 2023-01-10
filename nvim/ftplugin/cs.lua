local keymap = vim.keymap -- for conciseness
local group = vim.api.nvim_create_augroup("Key bindings for file type", {clear = true})

vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
    pattern = {"cs", "*.cs"},
    group = group,
    command = "lua setKeyBindings()"
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.cs",
    group = group,
    command = "lua clearKeyBindings()"
})

function setKeyBindings()
    local fileTy = vim.api.nvim_buf_get_option(0, "filetype")

    if fileTy == 'cs' then
        -- OmniSharp bindings
        keymap.set("n", "<leader>rt", ":OmniSharpRunTests<CR>")
        --keymap.set("n", "<leader>rt", ":TestNearest<CR>")
        keymap.set("n", "<leader>rf", ":OmniSharpRunTestFixture<CR>")
        keymap.set("n", "<leader>ra", ":OmniSharpRunAllTest<CR>")
        keymap.set("n", "<leader>rl", ":OmniSharpRunLastTest<CR>")
        keymap.set("n", "<leader>t", ":OmniSharpHighlightTypes<CR>")
        keymap.set("n", "<leader>b",  ":OmniSharpBuildAsync<CR>")
        keymap.set("n", "<leader><Space>", ":OmniSharpGetCodeActions<CR>")
        keymap.set("n", "<leader>nm", ":OmniSharpRename<CR>")
    end
end

function clearKeyBindings()
        keymap.set("n", "<leader>b",  "<Nop>")
        keymap.set("n", "<leader>rf", "<Nop>")
        keymap.set("n", "<leader>rt", "<Nop>")
        keymap.set("n", "<leader>ra", "<Nop>")
        keymap.set("n", "<leader>rl", "<Nop>")
        keymap.set("n", "<leader>t", "<Nop>")
        keymap.set("n", "<leader><Space>", "<Nop>")
        keymap.set("n", "<leader>nm", ":Lspsaga rename<CR>")
end
