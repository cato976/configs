--local setup, omnisharp = pcall(require, "omnisharp")
--if not setup then
--    print("OmniSharp not found!")
--    return
--end

local api = vim.api
local keymap = vim.keymap
local group = vim.api.nvim_create_augroup("Key bindings for file type", {clear = true})

vim.g["OmniSharp_server_path"] = os.getenv("HOME") .. "/.omnisharp/OmniSharp.exe"

api.nvim_create_autocmd(
"FileType",
{
    group = group,
    pattern = { "cs" },
    callback = function ()
        vim.schedule(setKeybind)
    end,
})

function setKeybind()
        keymap.set("n", "<leader>rt", ":OmniSharpRunTests<CR>", {buffer=true, desc="c# run test"})
        --keymap.set("n", "<leader>rt", ":TestNearest<CR>")
        keymap.set("n", "<leader>rf", ":OmniSharpRunTestFixture<CR>", {buffer=true, desc="c# run test fixture"})
        keymap.set("n", "<leader>ra", ":OmniSharpRunAllTest<CR>", {buffer=true, desc="c# run all test"})
        keymap.set("n", "<leader>rl", ":OmniSharpRunLastTest<CR>", {buffer=true, desc="c# run last test"})
        keymap.set("n", "<leader>t", ":OmniSharpHighlightTypes<CR>", {buffer=true, desc="c# highlight types"})
        keymap.set('n', "<leader>b", ":OmniSharpBuildAsync<CR>", {buffer=true, desc="c# build command"})
        keymap.set("n", "<leader><Space>", ":OmniSharpGetCodeActions<CR>", {buffer=true, desc="c# get code actions"})
        keymap.set("n", "<leader>nm", ":OmniSharpRename<CR>", {buffer=true, desc="c# rename"})
end
