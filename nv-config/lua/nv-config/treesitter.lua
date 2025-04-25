require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  -- ensure_installed = {
  --   "c",
  --   "lua",
  --   "vim",
  --   "vimdoc",
  --   "query",
  --   "javascript",
  --   "python",
  --   "norg",
  --   "latex",
  --   "markdown"
  -- },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  indent = { enable = true },
  highlight = {
    -- `false` will disable the whole extension
    -- enable = true,
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust", "javascript" },
    -- disable = { "python", "javascript", "lua", "markdown", },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  --  indent = {
  --    enable = true
  --  }
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = true,
  -- },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",     -- set to `false` to disable one of the mappings
      -- node_incremental = "grn",
      node_incremental = "grb",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})
