" Create map to add keys to 
let g:which_key_map = { }

let g:which_key_map.s = {
            \ 'name' : '+omnisharp'
            \ }

" Register which key map
" s is for omnisharp
call which_key#register('<Space>', "g:which_key_map")
