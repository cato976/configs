--local setup, omnisharp = pcall(require, "omnisharp")
--if not setup then
--    print("OmniSharp not found!")
--    return
--end


vim.g["OmniSharp_server_path"] = os.getenv("HOME") .. "/.omnisharp/OmniSharp.exe"

