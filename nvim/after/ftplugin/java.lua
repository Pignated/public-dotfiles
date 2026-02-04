if os.getenv("USING_JAVA") ~= "1" then
    return
end

local jdtls_plugin_path = os.getenv("NVIM_JDTLS_HOME")
if jdtls_plugin_path then 
    vim.opt.rtp:append(jdtls_plugin_path)
end


local status, jdtls = pcall(require, 'jdtls')
if not status then 
    return
end

local jdtls_bin = os.getenv("JDTLS_PATH")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status,cmp_lsp = pcall(require, "cmp_nvim_lsp")
capabilities = cmp_lsp.default_capabilities(capabilities)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(),':p:h:t') or "default_project"
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name or "default"
local config = {
    cmd = { jdtls_bin, "-data", workspace_dir },
    root_dir = jdtls.setup.find_root({'.git','mvnw','pom.xml'}),
    capabilities = capabilities,
}

jdtls.start_or_attach(config)

local group = vim.api.nvim_create_augroup("JavaOrganizeImports", {clear = true} )
vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*.java",
    callback = function()
        require('jdtls').organize_imports()
    end,
})

vim.keymap.set('n','<leader>oi',function() require('jdtls').organize_imports() end, {desc = "Organize Imports"})
