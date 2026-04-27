if os.getenv("USING_PYTHON") ~= "1" then
    return
end
vim.lsp.start({
  name = 'basedpyright',
  cmd = {'basedpyright-langserver', '--stdio'},
  root_dir = vim.fs.root(0, {'pyproject.toml', 'setup.py', '.git', 'requirements.txt', 'pyrightconfig.json'}),
  on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
    end,
  settings = {
    basedpyright = {
      analysis = {
            typeCheckingMode ="standard",
      }
    }
  }
})

-- Ensure the UI highlights are active globally
vim.diagnostic.config({
  underline = true,
  virtual_text = {
        severity = {min = vim.diagnostic.severity.ERROR},
    },
  signs = true,
    float = {
    source = true,
    },
})
