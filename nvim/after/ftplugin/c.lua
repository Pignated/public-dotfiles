
if os.getenv("USING_C") ~= "1" then
    return
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.start({
    name = 'clangd',
    cmd = {'clangd'},
    
})
