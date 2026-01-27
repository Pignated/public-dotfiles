vim.opt.mouse = ""
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup({
    spec = {
        { "catppuccin/nvim",                 name = "catppuccin",                 priority = 1000},
        { "nvim-telescope/telescope.nvim",                   dependencies = { 'nvim-lua/plenary.nvim' } },
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        { "hrsh7th/cmp-nvim-lsp",            "hrsh7th/nvim-cmp",                  "hrsh7th/cmp-vsnip", },
        { "m4xshen/autoclose.nvim", },
        { "williamboman/mason.nvim",         "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
        { "nvim-lualine/lualine.nvim" },
        { "nvim-tree/nvim-tree.lua" },
        { "nvim-tree/nvim-web-devicons" },
        { "mrcjkb/rustaceanvim", version = "^6", lazy = false},
        { "amitds1997/remote-nvim.nvim", version = "*", -- Pin to GitHub releases
            dependencies = {
                "nvim-lua/plenary.nvim", -- For standard functions
                "MunifTanjim/nui.nvim", -- To build the plugin UI
                "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
            },
            config = true,
        }
    },
    checker = { enabled = true, notify = false },
})
vim.opt.number = true
vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.lsp.config('*', {
    root_markers = {'.git'}
})
require("autoclose").setup({
    options = {
        disabled_filetypes = { "text", "latex", "texlab", "tex", "nix" },
        pair_spaces = true,
        auto_indent = true,
    },
})
require("nvim-tree").setup()
-- mason / lsp setup
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup()
vim.lsp.config('*', {
    root_markers = { '.git' },
})

vim.lsp.enable("clangd")
vim.lsp.enable("rust-analyzer")

local cmp = require('cmp')
cmp.setup {
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
}
vim.keymap.set("n","<Leader>e", vim.diagnostic.open_float, {desc = "Open Diagnostic Float"})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.hover)
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "c_sharp", "cpp", "css", "csv", "dockerfile", "git_config", "gitcommit",
        "gitignore", "html", "http", "java", "javascript", "json", "lua", "markdown",
        "nginx", "python", "robots", "sql", "ssh_config", "toml", "typescript", "vim", "xml",
        "yaml", "kotlin", "asm", "nix", "rust"
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

-- lualine
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 500,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            'branch',
            {
                'diagnostics',
                symbols = { error = '⏹ ', warn = '', info = '', hint = '' },
            },
        },
        lualine_c = {
            {
                'filename',
                symbols = {
                    modified = '●',
                    readonly = '-',
                    unnamed = 'unnamed',
                    newfile = 'new',
                },
            },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argv(0) == "" or vim.fn.argv(0) == "." then
            vim.cmd("Telescope find_files hidden=true")
        end
    end,
})

