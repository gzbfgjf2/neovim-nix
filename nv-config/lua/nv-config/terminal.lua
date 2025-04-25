local te_buf = nil
local te_win_id = nil

local v = vim
local fun = v.fn
local cmd = v.api.nvim_command
local gotoid = fun.win_gotoid
local getid = fun.win_getid

local function open_terminal()
  if fun.bufexists(te_buf) ~= 1 then
    cmd("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
    cmd("vert sp | winc L | te")
    te_win_id = getid()
    te_buf = fun.bufnr('%')
  elseif gotoid(te_win_id) ~= 1 then
    cmd("vert sb " .. te_buf .. "| winc L ")
    te_win_id = getid()
  end
  cmd("startinsert")
end

local function hide_terminal()
  if gotoid(te_win_id) == 1 then
  end
end

local function toggle_terminal()
  if gotoid(te_win_id) == 1 then
    cmd("hide")
  else
    open_terminal()
  end
end


vim.keymap.set({ 'n', 't' }, '<C-x>', toggle_terminal)
