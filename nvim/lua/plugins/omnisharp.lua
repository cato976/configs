--local setup, omnisharp = pcall(require, "omnisharp")
--if not setup then
--    print("OmniSharp not found!")
--    return
--end

vim.cmd([[
    let g:OmniSharp_server_path = "~/.omnisharp/OmniSharp.exe"
]])