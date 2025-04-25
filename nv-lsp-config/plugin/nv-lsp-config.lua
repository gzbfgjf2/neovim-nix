vim.lsp.config('*', {
  -- capabilities = {
  --   textDocument = {
  --     semanticTokens = {
  --       multilineTokenSupport = true,
  --     }
  --   }
  -- },
  root_markers = { '.git' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
})

vim.lsp.config('luals', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
})

vim.lsp.config("rust-analyzer", {

  cmd = { "rust-analyzer" },
  -- root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.toml", ".git" }, { upward = true })[1]),
  filetypes = { "rust" },
  -- on_attach = function(client, bufnr)
  --   local opts = { buffer = bufnr, silent = true }
  --
  --   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  --   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  --   vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  --   vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  --
  --   -- Optional: format on save
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ async = false })
  --     end,
  --   })
  -- end,
  -- settings = {
  --   ["rust-analyzer"] = {
  --     cargo = { allFeatures = true },
  --     checkOnSave = { command = "clippy" },
  --   },
  -- },
})

-- Start or attach to the LSP
-- vim.lsp.start(rust_lsp)

vim.lsp.enable({ 'luals', 'pyright', 'rust-analyzer' })
