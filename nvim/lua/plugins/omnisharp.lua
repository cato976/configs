--local setup, omnisharp = pcall(require, "omnisharp")
--if not setup then
--    print("OmniSharp not found!")
--    return
--end

local keymap = vim.keymap -- for conciseness

vim.g["OmniSharp_server_path"] = os.getenv("HOME") .. "/.omnisharp/OmniSharp.exe"

-- OmniSharp bindings
keymap.set("n", "<leader>rt", ":OmniSharpRunTests<CR>")
keymap.set("n", "<leader>rt", ":TestNearest<CR>")
keymap.set("n", "<leader>rf", ":OmniSharpRunTestFixture<CR>")
keymap.set("n", "<leader>ra", ":OmniSharpRunAllTest<CR>")
keymap.set("n", "<leader>rl", ":OmniSharpRunLastTest<CR>")
keymap.set("n", "<leader>t", ":OmniSharpHighlightTypes<CR>")
keymap.set("n", "<leader>b",  ":OmniSharpBuildAsync<CR>")
keymap.set("n", "<leader><Space>", ":OmniSharpGetCodeActions<CR>")
keymap.set("n", "<leader>nm", ":OmniSharpRename<CR>")
