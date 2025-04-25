require("conform").setup({
  formatters_by_ft = {
    -- lua = { "stylua" },
    lua = { lsp_format = "first" },
    -- Conform will run multiple formatters sequentially
    python = { "ruff_format" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format()
end, { desc = "Format" })
