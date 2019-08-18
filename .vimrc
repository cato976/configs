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
Plugin 'ianks/vim-tsx'
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
colorscheme one



" }}}

" Neovim Basics ----------------------------------------------------------------------{{{
if has("nvim")
    set inccommand=split
    let g:neomake_open_list=2
    autocmd! BufWritePost * Neomake
    au FileType cs let g:neomake_cs_enabled_makers = ['msbuild']
    " python
    "let g:python3_host_prog = "C:/Users/catoan/AppData/Local/Programs/Python/Python37/python3.7.exe"
    let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-emmet', 'coc-tslint', 'coc-prettier', 'coc-html']
endif
" }}}

" Highlighed Yank Plugin ----------------------------------------------------------------------{{{
if has("vim")
    if !exist('##TextYankPost')
        map y <Plug>(highlightedyank)
    endif
endif
" }}}

" Airline ----------------------------------------------------------------------{{{
" Set up Airline
set laststatus=2
set showtabline=2
set noshowmode
set encoding=utf-8 
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
if has("gui_running")
    set guifont=Inconsolata_for_Powerline:h12i:cANSI
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

" Leader ----------------------------------------------------------------------{{{
let mapleader = ","
nnoremap <leader>p mm%x`mx
nnoremap <leader>c :Neomake!<CR>
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

let g:OmniSharp_server_path = 'C:\Users\catoan\.omnisharp/OmniSharp.exe'
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

" vim-addon-manager ---------------------------------------------------------------------{{{
set nocompatible | filetype indent plugin on | syn on
set runtimepath+=~/.vim/bundle/vim-addon-manager
" }}}
