local setup, nvim_tree = pcall(require, "which-key")
if not setup then
    return
end

local wk = require("which-key")

--" Create map to add keys to 
--let g:which_key_map = { }
--
--let g:which_key_map.a = {
--            \ 'name' : '+add-watch'
--            \ }
--
--let g:which_key_map.d = {
--            \ 'name' : '+vimspector'
--            \ }
--
--let g:which_key_map.e = {
--            \ 'name' : '+tab-vimrc'
--            \ }
--
--let g:which_key_map.g = {
--            \ 'name' : '+git'
--            \ }
--
--let g:which_key_map.n = {
--            \ 'name' : '+omnisharp-Rename'
--            \ }
--
--let g:which_key_map.t = {
--            \ 'name' : '+omnisharp-HighlightTypes'
--            \ }
--
--let g:which_key_map.s = {
--            \ 'name' : '+omnisharp-Server'
--            \ }
--
--let g:which_key_map.w = {
--            \ 'name' : '+vimwiki',
--            \ '<Space>' : ['<Space> w <Space>', '+diary']
--            \ }
--
--" Register which key map
--" s is for omnisharp


wk.register({
    ["<leader>a"] = {
        name = "+add-watch",
    },
    ["<leader>e"] = {
        name = "+tab-vimrc"
    },
    ["<leader>g"] = {
        name = "+git"
    },
    ["<leader>s"] = {
        name = "+omnisharp-Server",
    },
    ["<leader>t"] = {
        name = "+omnisharp-HighlightTypes",
    },
    ["<leader>n"] = {
        --name = "+omnisharp-Rename",
        m = {
            "+omnisharp-Rename"
        }
    },
    ["<leader>w"] = {
        name = "+vimwiki",
        space = {
            "+diary"
        }
    },
})
