local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local cpm_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cpm_nvim_lsp_status then
    return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
    return
end

local keymap = vim.keymap

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- set keybinds
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_actions<CR>", opts)
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

    if client.name == "tsserver" then
        keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
    end
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
    capabilites = capabilities,
    on_attach = on_attach
})

typescript.setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach
    }
})

lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})
