-- package.loaded["_G"]["Snacks"] = nill
-- package.loaded["_G"]["package"]["loaded"]["snacks"] = nill


require("snacks").setup({
  -- preset = "ivy",
  -- layout = {
  --   box = "vertical",
  --   backdrop = true,
  --   row = -1,
  --   width = 0,
  --   height = 1,
  --   border = "bottom",
  --   title = " {title} {live} {flags}",
  --   title_pos = "left",
  --   { win = "input", height = 1, border = "bottom" },
  --   {
  --     box = "horizontal",
  --     { win = "list", border = "none" },
  --     { win = "preview", title = "{preview}", width = 0.6, border = "left" },
  --   },
  styles = {
    input = {
      backdrop = false,
      position = "float",
      border = "none",
      -- title_pos = "center",
      height = 1,
      width = function()
        return math.max(math.floor(vim.o.columns * 0.5), 80)
      end,
      -- min_width = 80,
      -- relative = "editor",
      -- noautocmd = true,
      row = 0,
      -- col = "50%",
      -- relative = "cursor",
      -- row = -3,
      -- col = 0,
      wo = {
        winhighlight =
        "NormalFloat:NormalFloat,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
        cursorline = false,
      },
      bo = {
        filetype = "snacks_input",
        buftype = "prompt",
      },
      --- buffer local variables
      b = {
        completion = false, -- disable blink completions in input
      },
      keys = {
        n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
        i_esc = {
          "<esc>",
          { "cmp_close", "stopinsert" },
          mode = "i",
          expr = true
        },
        i_cr = {
          "<cr>",
          { "cmp_accept", "confirm" },
          mode = { "i", "n" },
          expr = true
        },
        i_tab = {
          "<tab>",
          { "cmp_select_next", "cmp" },
          mode = "i",
          expr = true
        },
        i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
        i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
        i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
        q = "cancel",
      },
    }
  },
  picker = {
    prompt = "",
    icons = { files = { enabled = false } },
    layout = {
      -- layout = {
      --   box = "vertical",
      --   backdrop = false,
      --   -- row = -2,
      --   position="bottom",
      --   width = 0,
      --   height = 0.4,
      --   border = "none",
      --   { win = "input", height = 1, border = "none" },
      --   {
      --     box = "horizontal",
      --     { win = "list", border = "none" },
      --     { win = "preview", title = "{preview}", width = 0.6, border = "none" },
      --   },
      -- },
      preview = false,
      layout = {
        backdrop = false,
        width = 0.5,
        min_width = 80,
        height = 0.4,
        min_height = 3,
        box = "vertical",
        -- border = "rounded",
        posiiton = "top",
        row = 0,
        -- title = "{title}",
        -- title_pos = "center",
        { win = "input", height = 1, border = "none" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "none" },
      }

    }
  },
  input = { icon = "" }
})


local map = vim.keymap.set
local snacks = require("snacks") -- Assuming `snacks` is your plugin/module

-- Core
map("n", "<leader><space>", function() snacks.picker.smart() end,
  {
    desc = "Smart Find Files"
  })
map("n", "<leader>,", function() snacks.picker.buffers() end,
  {
    desc = "Buffers"
  })
map("n", "<leader>/", function() snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>:", function() snacks.picker.command_history() end,
  {
    desc = "Command History"
  })
map("n", "<leader>n", function() snacks.picker.notifications() end,
  {
    desc = "Notification History"
  })
map("n", "<leader>e", function() snacks.explorer() end,
  {
    desc = "File Explorer"
  })

-- Find
map("n", "<leader>fb", function() snacks.picker.buffers() end,
  {
    desc = "Buffers"
  })
-- map("n", "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>ff", function() snacks.picker.files() end,
  {
    desc = "Find Files"
  })
map("n", "<leader>fg", function() snacks.picker.git_files() end,
  {
    desc = "Find Git Files"
  })
map("n", "<leader>fp", function() snacks.picker.projects() end,
  {
    desc = "Projects"
  })
map("n", "<leader>fr", function() snacks.picker.recent() end,
  { desc = "Recent" })

-- Git
map("n", "<leader>gb", function() snacks.picker.git_branches() end,
  {
    desc = "Git Branches"
  })
map("n", "<leader>gl", function() snacks.picker.git_log() end,
  {
    desc = "Git Log"
  })
map("n", "<leader>gL", function() snacks.picker.git_log_line() end,
  {
    desc = "Git Log Line"
  })
map("n", "<leader>gs", function() snacks.picker.git_status() end,
  {
    desc = "Git Status"
  })
map("n", "<leader>gS", function() snacks.picker.git_stash() end,
  {
    desc = "Git Stash"
  })
map("n", "<leader>gd", function() snacks.picker.git_diff() end,
  {
    desc = "Git Diff (Hunks)"
  })
map("n", "<leader>gf", function() snacks.picker.git_log_file() end,
  {
    desc = "Git Log File"
  })

-- Grep
map("n", "<leader>sb", function() snacks.picker.lines() end,
  {
    desc = "Buffer Lines"
  })
map("n", "<leader>sB", function() snacks.picker.grep_buffers() end,
  {
    desc = "Grep Open Buffers"
  })
map("n", "<leader>sg", function() snacks.picker.grep() end, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() snacks.picker.grep_word() end,
  {
    desc = "Visual selection or word"
  })

-- Search
map("n", '<leader>s"', function() snacks.picker.registers() end,
  {
    desc = "Registers"
  })
map("n", "<leader>s/", function() snacks.picker.search_history() end,
  {
    desc = "Search History"
  })
map("n", "<leader>sa", function() snacks.picker.autocmds() end,
  {
    desc = "Autocmds"
  })
map("n", "<leader>sc", function() snacks.picker.command_history() end,
  {
    desc = "Command History"
  })
map("n", "<leader>sC", function() snacks.picker.commands() end,
  {
    desc = "Commands"
  })
map("n", "<leader>sd", function() snacks.picker.diagnostics() end,
  {
    desc = "Diagnostics"
  })
map("n", "<leader>sD", function() snacks.picker.diagnostics_buffer() end,
  {
    desc = "Buffer Diagnostics"
  })
map("n", "<leader>sh", function() snacks.picker.help() end,
  {
    desc = "Help Pages"
  })
map("n", "<leader>sH", function() snacks.picker.highlights() end,
  {
    desc = "Highlights"
  })
map("n", "<leader>si", function() snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() snacks.picker.keymaps() end,
  {
    desc = "Keymaps"
  })
map("n", "<leader>sl", function() snacks.picker.loclist() end,
  {
    desc = "Location List"
  })
map("n", "<leader>sm", function() snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() snacks.picker.man() end,
  { desc = "Man Pages" })
map("n", "<leader>sp", function() snacks.picker.lazy() end,
  {
    desc = "Search for Plugin Spec"
  })
map("n", "<leader>sq", function() snacks.picker.qflist() end,
  {
    desc = "Quickfix List"
  })
map("n", "<leader>sR", function() snacks.picker.resume() end,
  { desc = "Resume" })
map("n", "<leader>su", function() snacks.picker.undo() end,
  {
    desc = "Undo History"
  })
map("n", "<leader>uC", function() snacks.picker.colorschemes() end,
  {
    desc = "Colorschemes"
  })

-- LSP
map("n", "gd", function() snacks.picker.lsp_definitions() end,
  {
    desc = "Goto Definition"
  })
map("n", "gD", function() snacks.picker.lsp_declarations() end,
  {
    desc = "Goto Declaration"
  })
map("n", "gfr", function() snacks.picker.lsp_references() end,
  {
    desc = "References",
    nowait = true
  })
map("n", "gI", function() snacks.picker.lsp_implementations() end,
  {
    desc = "Goto Implementation"
  })
map("n", "gy", function() snacks.picker.lsp_type_definitions() end,
  {
    desc = "Goto T[y]pe Definition"
  })
map("n", "<leader>ss", function() snacks.picker.lsp_symbols() end,
  {
    desc = "LSP Symbols"
  })
map("n", "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end,
  {
    desc = "LSP Workspace Symbols"
  })
