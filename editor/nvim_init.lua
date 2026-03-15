--===========================================================
--            PURE NEOVIM - DEVOPS EDITION
--===========================================================

-- Leader
vim.g.mapleader = " "

--===========================================================
-- Básico
--===========================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.background = "dark"

--===========================================================
-- Búsqueda inteligente
--===========================================================
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.keymap.set("n", "<leader><space>", "<cmd>nohlsearch<CR>")

--===========================================================
-- Navegación estilo IDE (sin LSP pesado)
--===========================================================
vim.opt.wildmenu = true
vim.opt.path:append("**")
vim.opt.wildignore:append({
  "*/.git/*",
  "*/node_modules/*",
  "*/__pycache__/*",
  "*.pyc",
})

-- Usar ripgrep si existe
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep"
end

vim.keymap.set("n", "<leader>g", ":grep ")
vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")
vim.keymap.set("n", "<leader>c", "<cmd>cclose<CR>")

--===========================================================
-- Indentación global (DevOps-friendly)
--===========================================================
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

--===========================================================
-- FileType específico
--===========================================================

-- Crear grupo limpio de autocmds
local augroup = vim.api.nvim_create_augroup("DevOpsConfig", { clear = true })

-- Python
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "88"
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-- YAML
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Bash
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "sh",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Terraform
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "terraform",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

--===========================================================
-- Herramientas externas
--===========================================================

vim.keymap.set("n", "<leader>f", "<cmd>!black %<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>!ruff %<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>!terraform fmt %<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>!kubectl apply --dry-run=client -f %<CR>")
vim.keymap.set("n", "<leader>s", "<cmd>!shellcheck %<CR>")

--===========================================================
-- Ctags navegación
--===========================================================
vim.opt.tags = "./tags;,tags;"

-- Ctrl-] y Ctrl-t funcionan igual que en Vim

--===========================================================
-- Performance
--===========================================================
vim.opt.updatetime = 300
vim.opt.hidden = true

--===========================================================
-- Completion
--===========================================================
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

-- Omni fallback si no hay LSP
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "sh", "terraform", "yaml", "json", "dockerfile" },
  callback = function()
    vim.opt_local.omnifunc = "syntaxcomplete#Complete"
  end,
})

--===========================================================
-- Markdown fenced languages
--===========================================================
vim.g.markdown_fenced_languages = {
  "html",
  "python",
  "bash=sh",
  "javascript",
  "js=javascript",
  "json=javascript",
  "yaml",
  "yml=yaml",
}

