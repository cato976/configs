" Plugins ----------------------------------------------------------------------{{{ Set up for vundle
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-powerline'
Plugin 'powerline/powerline-fonts'
Plugin 'sjl/badwolf'
Plugin 'rakr/vim-one'
Plugin 'leafgarland/typescript-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-syntastic/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'MarcWeber/vim-addon-manager'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'w0rp/ale'
Plugin 'cato976/vim-test'
Plugin 'cato976/omnisharp-vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'cato976/vim-spotifysearch'
if has('nvim')
    Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plugin 'neoclide/coc.nvim', { 'do': 'yarn intstall --frozen-lockfile'}
else
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'roxma/nvim-yarp'
    Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'neomake/neomake'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'machakann/vim-highlightedyank'
Plugin 'OrangeT/vim-csharp'
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/VimFold4C'
Plugin 'craigemery/vim-autotag'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
Plugin 'ianks/vim-tsx'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
call vundle#end()
" }}}

" Basics  ----------------------------------------------------------------------{{{

" vimrc folds
autocmd FileType vim setlocal fdc=1
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

set nocompatible
set hlsearch
set incsearch
set tabstop=8
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set number
set relativenumber
set scrolloff=999
set spell
set spelllang=en_us
syntax on

let g:deoplete#enable_at_startup = 1
filetype plugin indent on
set background=dark
colorscheme badwolf

highlight Pmenu ctermbg=gray guibg=gray


" }}}

" Leader ----------------------------------------------------------------------{{{
let mapleader = ","
nnoremap <leader>c :Neomake!<CR>
nnoremap <leader>ev :<C-U>tab drop $MYVIMRC<CR>
" }}}

" Diff ----------------------------------------------------------------------{{{ Set diff compare
set diffopt=vertical,filler,context:4,foldcolumn:1,indent-heuristic,algorithm:patience,internal	 " diff options
" Detect if vim is started as a diff tool (vim -d, vimdiff)
" NOTE: Does not work when you start Vim as usual and enter diff mode using
" diffthis

augroup aug_color_scheme
    au!

    autocmd ColorScheme badwolf call s:PatchColorScheme()
augroup END

function s:PatchColorScheme()
    hi! link DiffChange NONE
    hi! clear DiffChange
    hi! DiffText term=NONE ctermfg=215 ctermbg=233 cterm=NONE guifg=#FFB86C guibg=#14141a gui=NONE

endfunction

augroup aug_diffs
    au!

    " Inspect whether some windows are diff mode, and apply changes for
    " such windows 
    " Run asynchronously, to ensure '&diff' option is properly set in VIM
    au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')

    " Highlight VCS conflict markers
    "au VimEnter,WinEnter * if !exists('w:_vsc_conflict_marker_match') |
                "\ let:_vsc_conflict_marker_match = match('ErrorMsg', '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$') |
                "\ endif
augroup END

" In diff mode:
" - Disable syntax highlighting
" - Disable spell checking
function CheckDiffMode(timer)
    let curwin = winnr()

    " Check each window
    for _win in range(1, winnr('$'))
        exe "noautocmd " . _win . "wincmd w"

        call s:change_option_in_diffmode('b:', 'syntax', 'off')
        call s:change_option_in_diffmode('w:', 'spell', 0, 1)
    endfor

    if &diff
        execute "NERDTreeClose"
    endif

    " Get back to original window
    exe "noautocmd " . curwin . "wincmd w"
endfunction

" Detect window or buffer local option is in sync with diff mode
function s:change_option_in_diffmode(scope, option, value, ...)
    let isBoolean = get(a:, "1", 0)
    let backupVarname = a:scope . "_old_" . a:option

    " Entering diff mode
    if &diff && !exists(backupVarname)
        exe "let " . backupVarname . "=&" . a:option
        call s:set_option(a:option, a:value, 1, isBoolean)
    endif

    " Exiting diff mode
    if !&diff && exists(backupVarname)
        let oldValue = eval(backupVarname)
        call s:set_option(a:option, oldValue, 1, isBoolean)
        exe "unlet " . backupVarname
    endif
endfunction

" Set option using set of setlocal , be it string or boolean value
function s:set_option(option, value, ...)
    let isLocal = get(a:, "1", 0)
    let isBoolean = get(a:, "2", 0)
    if isBoolean
        exe (isLocal ? "setlocal " : "set ") . (a:value ? "" : "no") . a:option
    else
        exe (isLocal ? "setlocal " : "set ") . a:option . "=" . a:value
    endif
endfunction

if &diff
    let s:is_started_as_vim_diff = 1
    syntax off
    setlocal nospell
endif

" close all windows when in diff mode
nnoremap <leader>q :call <SID>QuitWindow()<CR> 

function s:QuitWindow()
    execute "echom 'inside QuitWindow()'"
    if get(s:, 'is_started_as_vim_diff', 0)
        qall
        return
    endif

    quit
endfunction
" }}}

" Neovim Basics ----------------------------------------------------------------------{{{
if has("nvim")
    set inccommand=split
    let g:neomake_open_list=2
    autocmd! BufWritePost * Neomake
    au FileType cs let g:neomake_cs_enabled_makers = ['msbuild']
    " python
    "let g:python3_host_prog = "C:/Users/catoan/AppData/Local/Programs/Python/Python37/python3.7.exe"
    let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-emmet',
        \ 'coc-eslint',
        \ 'coc-tslint',
        \ 'coc-prettier',
        \ 'coc-html',
        \ 'coc-pairs',
        \ 'coc-snippets'
        \ ]
    set guifont=CascadiaCode\ Nerd\ Font
endif
" }}}

" Highlighed Yank Plugin ----------------------------------------------------------------------{{{
if has("vim")
    if !exist('##TextYankPost')
        map y <Plug>(highlightedyank)
    endif
endif
" }}}

" asyncomplete -----------------------------------------------------------------{{{
let g:asyncomplete_auto_popup = 0
" }}}
"
" Airline ----------------------------------------------------------------------{{{
" Set up Airline
set laststatus=2
set showtabline=2
set noshowmode
set encoding=utf-8 
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
if has("gui_running")
    "set guifont=Inconsolata_for_Powerline:h12i:cANSI
    "set guifont=Cascadia\ Code:h12i:cANSI
endif
" }}}

"" File Browser ----------------------------------------------------------------------{{{
" Tweaks for browser
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :NERDTree
augroup END
" }}}

" My Bindings ----------------------------------------------------------------------{{{
nnoremap <leader>ve :Vexplore<cr>
" }}}

" OmniSharp----------------------------------------------------------------------{{{ 
" OmniSharp bindings
nnoremap <leader>rt :OmniSharpRunTests<cr>
nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
nnoremap <leader>ra :OmniSharpRunAllTest<cr>
nnoremap <leader>rl :OmniSharpRunLastTest<cr>
nnoremap <leader>b :OmniSharpBuildAsync<cr>


" OmniSharp won't work without this setting
filetype plugin on
"let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_host = "http://localhost:2000"
let g:syntastic_cs_checkers = ['code_checker']

"let g:OmniSharp_server_path = 'C:\Users\catoan\.omnisharp\omnisharp-roslyn/OmniSharp.exe'
"let g:OmniSharp_server_path = 'C:\WS\Personal_Git\omnisharp-roslyn\bin\Debug\OmniSharp.Http.Driver\net461\OmniSharp.exe'
let g:OmniSharp_port = 2000

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 10

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono).
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'], 'typescript': ['prettier'] }
let g:ale_fixers = {
            \ 'typescript': ['prettier']
            \}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘' 
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow



augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>


    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

" Enable snippet completion
let g:OmniSharp_want_snippet=1
" }}}

" Auto-Complete ----------------------------------------------------------------------{{{
" File name auto-complete
set path+=**

" Show file options above the command line
set wildmenu

" Set the working directory to wherever the open file lives
set autochdir
" }}}

" Arduino ----------------------------------------------------------------------{{{
" Set path for Arduino
let g:hardy_arduino_path = 'C:\Program Files (x86)\Arduino\arduino_debug.exe'
"let g:hardy_window_name = '___MY_Arduino_Window___'
"let g:hardy_arduino_options = '.\template.ino'
let g:hardy_window_size = 15
" }}}

" Templates ----------------------------------------------------------------------{{{
if has("autocmd")
    function! AddToProjectFile(projectPath, filePath)
        echom system("AddFileToProject.exe --PathToProjectFile=" . a:projectPath . shellescape(' --NewFilePath=') . a:filePath)
    endfunction

    augroup templates
        au!
        " read in template files
        autocmd BufNewFile *.cs execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
        " parse special text in the templates after the read
        autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
        " search for NAMESPACE to get ready to replace it
        autocmd BufNewFile *.cs execute "normal! gg/NAMESPACE\<CR>"
        autocmd BufNewFile *.cs execute "write"
        autocmd BufNewFile *.cs call AddToProjectFile(expand('%:p'), expand('%'))
    augroup END
endif
" }}}

" Spotify ----------------------------------------------------------------------{{{
" Spotify
let g:spotify_country_code = 'US'
let g:spotify_playpause_key = "<F10>"
" }}}

" Test ----------------------------------------------------------------------{{{
if has('nvim')
    let test#strategy="neovim"
endif
" }}}

" AutoTags ----------------------------------------------------------------------{{{
let g:autotagTagsFile="tags"
" }}}

" UltiSnips ----------------------------------------------------------------------{{{
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" coc-snippets --------------------------------------------------------------------------{{{
" Trigger configuration.
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" }}}

" coc-rename ----------------------------------------------------------------------------{{{
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
" }}}

" coc-prettier --------------------------------------------------------------------------{{{
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" }}}

" coc#refresh() --------------------------------------------------------------------------{{{
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" }}}

" Use K to show documentation in preview window --------------------------{{{
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" }}}

" NERDTree ------------------------------------------------------------------------------{{{
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
" }}}

" vim-gutter ----------------------------------------------------------------------------{{{
"nmap ]h <Plug>(GitGutterNextHunk)
"nmap [h <Plug>(GitGutterPrevHunk)
set updatetime=1000
" }}}

" vim-addon-manager ---------------------------------------------------------------------{{{
set nocompatible | filetype indent plugin on | syn on
set runtimepath+=~/.vim/bundle/vim-addon-manager
" }}}
