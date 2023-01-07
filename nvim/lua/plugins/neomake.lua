vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.cs",
    command = "let g:neomake_cs_enabled_makers = ['msbuild']"
})
