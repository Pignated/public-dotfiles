-- putting the more general lsps like the html one here, incase it is used by things other than js
if vim.fn.executable("vscode-html-language-server") == 1 then 
    vim.lsp.config("html", {
        name = "html",
        cmd = {"vscode-html-language-server", "--stdio"},
        root_dir = vim.fs.root(0, {'.git','package.json'}),
    })
    vim.lsp.enable("html")
end

if vim.fn.executable("vscode-css-language-server") == 1 then 
    vim.lsp.config("css", {
        name = "css",
        cmd = {"vscode-css-language-server", "--stdio"},
        root_dir = vim.fs.root(0, {'.git','package.json'}),
        filetypes={'css'},
    })
    vim.lsp.enable("css")
end



if vim.fn.executable("typescript-language-server") == 1 then 
    vim.lsp.config("tsserver", {
        name = "tsserver",
        cmd = {"typescript-language-server", "--stdio"},
        root_dir = vim.fs.root(0, {'tsconfig.json','package.json'}),
        filetypes = {"javascript","typescript"}
    })
    vim.lsp.enable("tsserver")
end
