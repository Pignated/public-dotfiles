if os.getenv("USING_RUST") ~= "1" then 
    return
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("rust-analyzer", {
    name = "rust-analyzer",
    cmd = {'rust-analyzer'},
    root_dir= vim.fs.root(0,{'Cargo.toml', '.git'}),
    capabilities = capabilities,

    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
        }
    }
})
vim.lsp.enable("rust-analyzer")
local cmp = require('cmp')
cmp.setup({
    sources = {
        {name='nvim_lsp'}
    }
})
