local setup, nvim_tree = pcall(require, "which-key")
if not setup then
    return
end

local wk = require("which-key")
wk.register(mappings, opts)
