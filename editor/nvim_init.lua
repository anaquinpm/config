--===========================================================
-- Auto reload config when saving
--===========================================================

local reload_group = vim.api.nvim_create_augroup("AutoReloadConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = reload_group,
  pattern = {
    "*/nvim/init.lua",
    "*/nvim/lua/*.lua",
    "*/nvim/lua/**/*.lua",
  },
  callback = function()
    vim.cmd("source $MYVIMRC")
    print("Neovim config reloaded")
  end,
})

--===========================================================
--            PURE NEOVIM - DEVOPS EDITION
--===========================================================

-- Leader
vim.g.mapleader = ";"

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


--===========================================================
-- Bootstrap Mason (auto instalación si no existe)
--===========================================================

local mason_path = vim.fn.stdpath("data") .. "/lazy/mason.nvim"

if not vim.loop.fs_stat(mason_path) then
  print("Installing Mason...")

  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/williamboman/mason.nvim",
    mason_path,
  })
  print("RUN -> :Mason")
end

vim.opt.rtp:prepend(mason_path)

--===========================================================
-- Bootstrap plugins (same path as mason)
--===========================================================

local plugin_root = vim.fn.stdpath("data") .. "/lazy"

local function ensure_plugin(repo)
  local name = repo:match(".+/(.+)")
  local path = plugin_root .. "/" .. name

  if not vim.loop.fs_stat(path) then
    print("Installing " .. repo .. " ...")

    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/" .. repo .. ".git",
      path,
    })
  end

  vim.opt.rtp:prepend(path)
end

ensure_plugin("neovim/nvim-lspconfig")
ensure_plugin("hrsh7th/nvim-cmp")
ensure_plugin("hrsh7th/cmp-nvim-lsp")

--===========================================================
-- INSTALL this packages in Mason (npm requiered): 
-- nvim-lspconfig
-- nvim-cmp
-- bash-language-server
-- dockerfile-language-server
-- pyright
-- terraform-ls
-- vscode-json-language-server
-- yaml-language-server

--===========================================================
-- LSP MINIMALISTA DEVOPS
--===========================================================

-- Plugins (carga simple si existen)
local has_mason, mason = pcall(require, "mason")
local has_lspconfig, lspconfig = pcall(require, "lspconfig")
local has_cmp, cmp = pcall(require, "cmp")

if has_mason then
  mason.setup()
end

-- Capabilities para autocompletado
local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp_lsp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

--===========================================================
-- Servidores DevOps
--===========================================================

local servers = {
  "bashls",
  "pyright",
  "dockerls",
  "yamlls",
  "jsonls",
  "terraformls",
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
  vim.lsp.enable(server)
end

  -- YAML optimizado para Kubernetes
vim.lsp.config("yamlls", {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.yaml",
      },
    },
  },
})

vim.lsp.enable("yamlls")

--===========================================================
-- Keymaps LSP (estilo IDE ligero)
--===========================================================

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

--===========================================================
-- Autocompletado
--===========================================================

if has_cmp then
  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },

    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<C-e>"] = cmp.mapping.abort(),
    }),
  })
end

--===========================================================
-- Diagnósticos
--===========================================================

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
})