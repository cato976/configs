" Create map to add keys to 
let g:which_key_map = { }

let g:which_key_map.a = {
            \ 'name' : '+add-watch'
            \ }

let g:which_key_map.d = {
            \ 'name' : '+vimspector'
            \ }

let g:which_key_map.e = {
            \ 'name' : '+tab-vimrc'
            \ }

let g:which_key_map.g = {
            \ 'name' : '+git'
            \ }

let g:which_key_map.n = {
            \ 'name' : '+omnisharp-Rename'
            \ }

let g:which_key_map.t = {
            \ 'name' : '+omnisharp-HighlightTypes'
            \ }

let g:which_key_map.s = {
            \ 'name' : '+omnisharp-Server'
            \ }

let g:which_key_map.w = {
            \ 'name' : '+vimwiki'
            \ }

" Register which key map
" s is for omnisharp
call which_key#register('<Space>', "g:which_key_map")
