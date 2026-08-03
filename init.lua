-- ////////////////////////////////////////////////////////////////
-- options :
-- check options from :options
-- ////////////////////////////////////////////////////////////////
vim.opt.number = true                             -- line number
vim.opt.relativenumber = true                     -- relative line numbers
vim.opt.cursorline = true                         -- highlight current line
vim.opt.wrap = false                              -- don't wrap lines

vim.opt.tabstop = 2                               -- \t width
vim.opt.shiftwidth = 2                            -- indent width
vim.opt.softtabstop = 2
vim.opt.expandtab = true                          -- use spaces instead of tabs
vim.opt.smartindent = true                        -- smart auto-indent

vim.opt.ignorecase = true                         -- case insensitive search
vim.opt.smartcase = true                          -- case sensitive if uppercase in string

vim.opt.signcolumn = "yes"                        -- show a sign column on the left
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.pumheight = 10                            -- pop up menu height
vim.opt.fillchars = { eob = " " }                 -- hide "~" on empty lines

vim.opt.undofile = true                           -- save undo history across sessions
vim.opt.autoread = true                           -- auto-reload changes

vim.opt.clipboard:append("unnamedplus")           -- use system clipboard

vim.opt.splitright = true                         -- :split to the right
vim.opt.splitbelow = true                         -- :vsplit to bottom

vim.opt.termguicolors = true

-- ////////////////////////////////////////////////////////////////
-- plugins
-- ////////////////////////////////////////////////////////////////
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig.git" },
  { src = "https://github.com/sainnhe/gruvbox-material.git" },
  { src = "https://github.com/mason-org/mason.nvim.git" },
  { src = "https://github.com/ibhagwan/fzf-lua.git" },
  { src = "https://github.com/folke/which-key.nvim.git" },
  { src = "https://github.com/stevearc/oil.nvim.git" },
  { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local fzf = require("fzf-lua")
local wk = require("which-key")

require("oil").setup()
require("lualine").setup()

wk.setup({
  delay = 1000
})

wk.add({
  { "<leader>f", group = "Find / FZF" },
  { "<leader>w", group = "Windows" },
  { "<leader>t", group = "Tabs" },
})

-- ////////////////////////////////////////////////////////////////
-- theme
-- ////////////////////////////////////////////////////////////////
vim.cmd.colorscheme("gruvbox-material")


-- ////////////////////////////////////////////////////////////////
-- lsp
-- ////////////////////////////////////////////////////////////////
require("mason").setup({options = { theme = 'gruvbox-material' }})

-- lsp config puts the config in an lsp/<lsp-name>.lua file
-- and enable can look at this config

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')

-- ////////////////////////////////////////////////////////////////
-- keymap :
-- check commands from :help index	
-- check setted keymaps from :map
-- ////////////////////////////////////////////////////////////////
vim.g.mapleader = " "

-- Window
vim.keymap.set("n", "<Leader>ws", "<cmd>split<CR>", { desc = " Window Split" })
vim.keymap.set("n", "<Leader>wv", "<cmd>vsplit<CR>", { desc = " Window Vertical Split" })
vim.keymap.set("n", "<Leader>wh", "<cmd>wincmd h<CR>", { desc = " Move To Left Window" })
vim.keymap.set("n", "<Leader>wl", "<cmd>wincmd l<CR>", { desc = " Move To Right Window" })
vim.keymap.set("n", "<Leader>wj", "<cmd>wincmd j<CR>", { desc = " Move To Lower Window" })
vim.keymap.set("n", "<Leader>wk", "<cmd>wincmd k<CR>", { desc = " Move To Upper Window" })
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = " Move To Left Window" })
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = " Move To Right Window" })
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = " Move To Lower Window" })
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = " Move To Upper Window" })



-- FZF
vim.keymap.set("n", "<Leader>f", "<cmd>FzfLua<CR>", { desc = "Open Fzf" })
vim.keymap.set("n", "<Leader>ff", fzf.files, { desc = "Find Files" })
vim.keymap.set("n", "<Leader>fg", fzf.live_grep, { desc = "Grep Files" })
vim.keymap.set("n", "<Leader>fb", fzf.buffers, { desc = "Find Open Buffers" })
vim.keymap.set("n", "<Leader>fh", fzf.helptags, { desc = "Find Help" })

-- LSP
vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Goto Definition" })
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger LSP completion" })
vim.keymap.set("n", "<Leader>ld", vim.diagnostic.open_float, { desc = "Find Help" })

-- Terminal
vim.keymap.set("n", "<Leader>th", "<cmd>hor term<CR>", { desc = "Horizontal Terminal" })
vim.keymap.set("n", "<Leader>tv", "<cmd>vert term<CR>", { desc = "Vertical Terminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

-- Misc
vim.keymap.set("n", "<Leader>te", ":tabedit ", { desc = "Edit File In New Tab" })
vim.keymap.set("n", "<Leader>e", ":tabedit ", { desc = "Edit File In New Tab" })
vim.keymap.set("n", "<Leader>fc", "<cmd>tabedit ~/.config/nvim<CR>", { desc = "Find Config files" })
vim.keymap.set("n", "<Leader>q", "<cmd>wqall!<CR>", { desc = "Save Files And Quit" })
vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Prev Tab" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })


-- ////////////////////////////////////////////////////////////////
-- functionality
-- ////////////////////////////////////////////////////////////////
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking",
  callback = function()
    vim.hl.on_yank()
  end
})
