require("noice").setup({

  cmdline = {
    opts = {
      border = { style = "none", padding = { 0, 0 }, },
      position = {
        -- row = "0",
        -- col = "50%",
        row = "100%",
      },
      size = {
        -- min_width = 80,
        -- width = 0.5,
        width = "100%",
        height = "auto",
      },

      filter_options = {},
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      }
    },
    format = {
      -- cmdline = { pattern = "^:", icon = "", lang = "vim" },
      -- search_down = {
      --   kind = "search",
      --   pattern = "^/",
      --   icon = "",
      --   lang = "regex"
      -- },
      -- search_up = {
      --   kind = "search",
      --   pattern = "^%?",
      --   icon = "",
      --   lang = "regex"
      -- },
      -- filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      -- lua = {
      --   pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
      --   icon = "",
      --   lang = "lua"
      -- },
      -- help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      -- input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()}
      cmdline = false,
      search_down = false,
      saerch_up = false,
      filter = false,
      lua = false,
      help = false,
      input = false,
    }
  }
})
