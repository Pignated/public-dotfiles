
if os.getenv("USING_C") ~= "1" then
    return
end
local gcc_path = vim.fn.exepath("gcc")
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.start({
    name = 'clangd',
    cmd = {'clangd', "--fallback-style=webkit"},
    
})
