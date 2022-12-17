-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
    -- packer can manage itself
    use("wbthomason/packer.nvim")
    
    use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
    use("tpope/vim-fugitive")
    use("Lokaltog/vim-powerline")
    use("powerline/powerline-fonts")
    use("sjl/badwolf")
    use("rakr/vim-one")
    use("morhetz/gruvbox")
    use("dracula/vim")
    use("leafgarland/typescript-vim")
    use("tpope/vim-dispatch")
    use("vim-syntastic/syntastic")
    use("ctrlpvim/ctrlp.vim")
    use("SirVer/ultisnips")
    use("honza/vim-snippets")
    use("MarcWeber/vim-addon-manager")
    use("prabirshrestha/asyncomplete.vim")
    use("prabirshrestha/async.vim")
    --use("w0rp/ale")
    use("cato976/vim-test")
    use("skywind3000/asyncrun.vim")
    use("cato976/omnisharp-vim")
    use("tpope/vim-unimpaired")
    if vim.fn.has("win32") then
        use("cato976/vim-spotifysearch")
    end
    use("msgpack/msgpack")
    if vim.fn.has('nvim') then
        --use("Shougo/deoplete.nvim", { "do": ":UpdateRemotePlugins" }
        --use({"neoclide/coc.nvim", run = "yarn install --frozen-lockfile"})
        --use({"neoclide/coc.nvim", branch = "release"})

        -- managing & installing lsp servers
        use("williamboman/mason.nvim")
        use("williamboman/mason-lspconfig.nvim")

        -- configuring lsp servers
        use("neovim/nvim-lspconfig")
        use("hrsh7th/cmp-nvim-lsp") -- completion plugin
        use({ "glepnir/lspsaga.nvim", branch = "main" })
        use("jose-elias-alvarez/typescript.nvim")
        use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

        -- autocompletion
        use("hrsh7th/nvim-cmp") -- completion plugin
        use("hrsh7th/cmp-buffer") -- source for text in buffer
        use("hrsh7th/cmp-path") -- source for file system paths
       
        -- snippets
        use("L3MON4D3/LuaSnip") -- snippet engine
        use("saadparwaiz1/cmp_luasnip") -- for autocompletion
        use("rafamadriz/friendly-snippets") -- useful snippets

        --use("nvim-lua/completion-nvim")
        use("nvim-lua/diagnostic-nvim")
    else
        use("Shougo/deoplete.nvim")
        use("roxma/nvim-yarp")
        use("roxma/vim-hug-neovim-rpc")
    end
    use("neomake/neomake")
    use("vim-airline/vim-airline")

    use("vim-airline/vim-airline-themes")
    use("machakann/vim-highlightedyank")
    use("cato976/vim-csharp")
    use("LucHermitte/lh-vim-lib")
    use("LucHermitte/VimFold4C")
    use("craigemery/vim-autotag")
    use("Xuyuanp/nerdtree-git-plugin")
    use("tiagofumo/vim-nerdtree-syntax-highlight")
    use("scrooloose/nerdcommenter")
    use("ryanoasis/vim-devicons")
    use("ianks/vim-tsx")
    use("mattn/emmet-vim")
    use("airblade/vim-gitgutter")
    use("junegunn/fzf", { cmd = { "install"}})
    use("junegunn/fzf.vim")
    use("airblade/vim-rooter") -- Allow fzf to search from the root of the git repo
    use("haya14busa/is.vim") -- unhighlight search results
    use({"folke/which-key.nvim",
    config = function()
        require("which-key").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            }
        end
    }) -- pop-up key bindings
    use("prettier/vim-prettier") -- prittier
    use("mbbill/undotree")
    use("puremourning/vimspector") -- Debugging in vim
    use("szw/vim-maximizer")
    use("vimwiki/vimwiki")
    use({ "anuvyklack/pretty-fold.nvim",
        config = function()
            require('pretty-fold').setup()
        end
    })
    use({"nvim-tree/nvim-tree.lua",
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
