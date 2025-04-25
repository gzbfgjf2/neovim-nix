require('flash').setup({
  -- label = { after = true, before = false },
  -- keys = {
  --   {
  --     "s",
  --     mode = { "n", "x", "o" },
  --     function() require("flash").jump() end,
  --     desc = "Flash"
  --   },
  --   {
  --     "S",
  --     mode = { "n", "x", "o" },
  --     function() require("flash").treesitter() end,
  --     desc = "Flash Treesitter"
  --   },
  --   {
  --     "r",
  --     mode = "o",
  --     function()
  --       require("flash").remote()
  --     end,
  --     desc = "Remote Flash"
  --   },
  --   {
  --     "R",
  --     mode = { "o", "x" },
  --     function()
  --       require("flash")
  --           .treesitter_search()
  --     end,
  --     desc = "Treesitter Search"
  --   },
  --   -- {
  --   --   "<c-s>",
  --   --   mode = { "c" },
  --   --   function() require("flash").toggle() end,
  --   --   desc = "Toggle Flash Search"
  --   -- },
  -- },
  modes =
  { search = { enabled = false }, char = { enabled = false },
  },
})

local flash_mappings = {
  {
    "s",
    mode = { "n", "x", "o" },
    fn = function() require("flash").jump() end,
    desc = "Flash"
  },
  {
    "S",
    mode = { "n", "x", "o" },
    fn = function() require("flash").treesitter() end,
    desc = "Flash Treesitter"
  },
  {
    "r",
    mode = "o",
    fn = function() require("flash").remote() end,
    desc = "Remote Flash"
  },
  {
    "R",
    mode = { "o", "x" },
    fn = function()
      require("flash")
          .treesitter_search()
    end,
    desc = "Treesitter Search"
  },
  {
    "<C-s>",
    mode = "c",
    fn = function() require("flash").toggle() end,
    desc = "Toggle Flash Search"
  },
}

-- Apply the mappings
for _, map in ipairs(flash_mappings) do
  vim.keymap.set(map.mode, map[1], map.fn, { desc = map.desc })
end
