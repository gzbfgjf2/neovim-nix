vim.api.nvim_set_hl(0, "IndentBlanklineIndent1",
  {
    fg = "#e7edee",
    bg = "#e7edee"
  })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2",
  {
    fg = "#cfd4d5",
    bg = "#cfd4d5"
  })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent1",
  {
    fg = "#35383d",
    bg = "#35383d"
  })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2",
  {
    fg = "#3b3f4c",
    bg = "#3b3f4c"
  })
local highlight = {
  "IndentBlanklineIndent1",
  "IndentBlanklineIndent2"

}
require("ibl").setup({
  indent = { char = " ", highlight = highlight },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = { enabled = false },
})
