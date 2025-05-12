vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cmdheight = 0
vim.o.laststatus = 0
-- vim.o.laststatus = 2
-- vim.o.syntax = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.splitright = true
vim.o.signcolumn = "no"
-- vim.o.pumblend = 15
-- vim.o.tw = 79
-- vim.o.nuw = 1
vim.o.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20"
-- vim.o.guicursor= "v-c-sm:block,n-i-ci-ve:ver25,r-cr-o:hor20"

vim.g.tex_flavor = "latex"
vim.o.so = 999
vim.o.ve = "onemore"
-- vim.o.showmode= false

vim.o.showtabline = 0

vim.o.shell = "fish"
-- cmd
vim.cmd("filetype plugin indent on")

-- " Workaround for gk/gj
-- nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
-- nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

-- vim.cmd([[
--     " Get folding working with vscode neovim plugin
--         if(exists("g:vscode"))
--             nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
--             nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
--             nnoremap zc :call VSCodeNotify('editor.fold')<CR>
--             nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
--             nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
--             nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
--             nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
--
--             nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
--             nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
--             function! MoveCursor(direction) abort
--                 if(reg_recording() == '' && reg_executing() == '')
--                     return 'g'.a:direction
--                 else
--                     return a:direction
--                 endif
--             endfunction
--
--             nmap <expr> j MoveCursor('j')
--             nmap <expr> k MoveCursor('k')
--         endif
-- ]])
-- vim.cmd([[
--     " Get folding working with vscode neovim plugin
--         if(exists("g:vscode"))
--             nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
--             nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
--             nnoremap zc :call VSCodeNotify('editor.fold')<CR>
--             nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
--             nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
--             nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
--             nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
--         endif
-- ]])

vim.cmd([[
  cabbrev h vert h <C-R>=Eatchar('\s')<CR>
]])

--create cmd
-- https://www.reddit.com/r/neovim/comments/vemydn/my_command_for_full_screen_interactive_terminal/u/funbike
vim.cmd([[
  command! -nargs=? Terminal call Term(<q-args>)
]])
-- create functions
vim.cmd([[
  function! Term(args)
    if has('nvim')
      tabnew
      execute 'terminal ' . a:args
      " execute 'terminal'
      " execute a:args
      " no left gutter
      setlocal signcolumn=no
      setlocal norelativenumber
      setlocal nonumber
      " if no errors, auto-close
      " autocmd! TermClose <buffer=abuf> if !v:event.status | exec 'bd! '..expand('<abuf>') | endif | checktime
      startinsert
    elseif has('terminal')
      execute 'tab terminal ++close ' . a:args
    else
      execute 'silent !( ' . (a:args != '' ? a:args : $SHELL) . ') || ( echo "Hit Enter"; read; )' | redraw!
    endif
  endfunction
]])
vim.cmd([[
  func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
  endfunc
]])

vim.cmd([[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]])
-- autocmd
-- https://stackoverflow.com/questions/6726783/how-to-change-the-default-position-of-quickfix-window-in-vim
vim.cmd([[autocmd FileType qf wincmd L]])
-- https://neovim.discourse.group/t/how-to-automatically-close-the-split-window-after-selecting-the-option-from-the-reference-list/2953
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local bufnr = vim.fn.bufnr("%")
    vim.keymap.set("n", "e", function()
      vim.api.nvim_command([[execute "normal! \<cr>"]])
      vim.api.nvim_command(bufnr .. "bd")
    end, { buffer = bufnr })
  end,
  pattern = "qf",
})
-- vim.cmd("autocmd FileType qf ++once call nvim_input(':cclose<cr>')")
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "html",
    "css",
    "typescript",
    "json",
    "jsonc"
  },
  command =
  "setlocal shiftwidth=2 tabstop=2 ts=2 sts=2 sw=2 expandtab textwidth=79 formatoptions+=t",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml" },
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  command = "setlocal ts=2 sts=2 sw=2 expandtab textwidth=79",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "plaintex" },
  command = "setlocal ts=2 sts=2 sw=2 expandtab textwidth=79",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "plaintex", "tex", "markdown", "text" },
  command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "nix" },
  command = "setlocal ts=2 sts=2 sw=2 expandtab textwidth=79",
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "tex"},
--   command = "set spell",
-- })
vim.cmd([[
  augroup Python
    autocmd!
    autocmd FileType python map <buffer> <leader>wr :w<CR>:vert term python "%"<CR>
    autocmd FileType python set tw=79
  augroup END
]])
vim.cmd([[
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
]])
-- vim.cmd[[:nnoremap <silent> <CR> :nohlsearch<CR><CR>]]
vim.cmd([[autocmd InsertLeave * :normal `^]])

-- vim.cmd([[
--   augroup custom_highlight
--     autocmd!
--     au ColorScheme * highlight IndentBlanklineIndent1 guifg=lightgrey guibg=lightgrey
--     au ColorScheme * highlight IndentBlanklineIndent2 guifg=#D6DBDF   guibg=#D6DBDF
--     au ColorScheme * highlight Special guifg=#61afef
--     au ColorScheme * highlight link texCmd Statement
--     au ColorScheme * highlight link texCmdPart texCmd
--
--   augroup END
-- ]])
--
-- vim.cmd([[
--   augroup custom_highlight
--     autocmd!
--     " au ColorScheme onedark highlight IndentBlanklineIndent1 guifg=242 guibg=#35383d
--     " au ColorScheme onedark highlight IndentBlanklineIndent2 guifg=245 guibg=#3d3e40
--     " au ColorScheme onedark hi VertSplit guibg=#abb2bf guifg=#3b3f4c
--     " au ColorScheme onedark hi CurSearch guibg=#abcabc guifg=#aaabbb
--     " au ColorScheme onedark hi CurSearch guifg=#CCF381 guibg=#4831D4
--     au ColorScheme onedark hi CurSearch guifg=#4831D4 guibg=#CCF381
--     " au ColorScheme catpucin-latte highlight IndentBlanklineIndent2 guifg=245 guibg=120
--     " au ColorScheme catpucin-latte highlight IndentBlanklineIndent2 guifg=100 guibg=120
--   augroup END
-- ]])
-- " hi vertsplit guibg=grey guifg=#3b3f4c]
-- vim.cmd[[hi vertsplit guibg=#393fb1 guifg=#3b3f4c]]
-- vim.cmd([[color onedark]])
-- keymaps
-- vim.keymap.set('n', '<tab>', '<ESC>', { noremap = true })
-- vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
-- vim.keymap.set('n', '<tab>', ':', { noremap = true })
vim.keymap.set("n", ";", ":", { noremap = true })
-- vim.keymap.set('n', '<BS>', ':', { noremap = true })
vim.keymap.set("v", ";", ":", { noremap = true })
-- vim.keymap.set('n', ':', ';', { noremap = true })
-- vim.keymap.set('v', ':', ';', { noremap = true })
vim.keymap.set("n", "<c-s>", ":w<cr>", { noremap = true })

vim.keymap.set("n", "<leader>undo", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Leader>ecfv", ":e ~/.config/nvim/plugin/config.vim<Enter>",
  {
    noremap = true
  })
vim.keymap.set("n", "<Leader>scfv",
  ":so ~/.config/nvim/plugin/config.vim<Enter>", {
    noremap = true
  })
vim.keymap.set("n", "<Leader>einl", ":e ~/.config/nvim/init.lua<Enter>",
  {
    noremap = true
  })
vim.keymap.set("n", "<Leader>eluf", ":e ~/.config/nvim/lua/usr<Enter>",
  {
    noremap = true
  })
vim.keymap.set("n", "<Leader>sinl", ":luafile ~/.config/nvim/init.lua<Enter>",
  {
    noremap = true
  })
vim.keymap.set("n", "<Leader>ealy",
  ":e ~/.config/alacritty/alacritty.toml<Enter>", {
    noremap = true
  })
vim.keymap.set("n", "<Leader>etdt", ":e ~/.todo/todo.txt<Enter>",
  {
    noremap = true
  })
vim.keymap.set("n", "<Leader>ecff", ":e ~/.config/fish/config.fish<Enter>",
  {
    noremap = true
  })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>l", { noremap = true })
vim.keymap.set("n", "<Leader>i", "dd<up>o", { noremap = true })
-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",
--   { noremap = true })
-- vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",
--   { noremap = true })
-- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",
--   { noremap = true })
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",
--   { noremap = true })
-- vim.keymap.set("n", "<c-d>", "<c-d>zz0", { noremap = true })
-- vim.keymap.set("n", "<c-u>", "<c-u>zz0", { noremap = true })
-- vim.keymap.set("n", "<c-f>", "<c-f>zz0", { noremap = true })
-- vim.keymap.set("n", "<c-b>", "<c-b>zz0", { noremap = true })

vim.keymap.set("n", "<c-d>", "<c-d>0", { noremap = true })
vim.keymap.set("n", "<c-u>", "<c-u>0", { noremap = true })
vim.keymap.set("n", "<c-f>", "<c-f>zz0", { noremap = true })
vim.keymap.set("n", "<c-b>", "<c-b>zz0", { noremap = true })

vim.keymap.set("v", "y", "ygv<Esc>", { noremap = true })
-- vim.keymap.set("n", "<c-d>", "20jzz", { noremap = true })
-- vim.keymap.set("n", "<c-u>", "20kzz", { noremap = true })
-- vim.keymap.set("n", "<c-f>", "40jzz", { noremap = true })
-- vim.keymap.set("n", "<c-b>", "40kzz", { noremap = true })

-- vim.keymap.set("n", "h", "hzz", { noremap = true })
-- vim.keymap.set("n", "j", "jzz", { noremap = true })
-- vim.keymap.set("n", "k", "kzz", { noremap = true })
-- vim.keymap.set("n", "l", "lzz", { noremap = true })
-- vim.keymap.set("n", "G", "Gzz", { noremap = true })
-- vim.cmd(' let mapleader = \"\\<BS>\" ')
-- vim.g.mapleader = vim.api.nvim_replace_termcodes('<BS>', true, false, true)
-- vim.g.mapleader = "<80>kb"
-- vim.g.mapleader = "<>"
-- vim.keymap.set('n', '<BS>', '<nop>', {noremap=true})

-- vim.keymap.set("n", "j", "<Left>", { noremap = true })
-- vim.keymap.set("n", "k", "<Down>", { noremap = true })
-- vim.keymap.set("n", "l", "<UP>", { noremap = true })
-- vim.keymap.set("n", ";", "<Right>", { noremap = true })
-- vim.keymap.set("v", "j", "<Left>", { noremap = true })
-- vim.keymap.set("v", "k", "<Down>", { noremap = true })
-- vim.keymap.set("v", "l", "<UP>", { noremap = true })
-- vim.keymap.set("v", ";", "<Right>", { noremap = true })

-- hightlight
--- important
--- vim.api.nvim_set_hl(0, 'SpecialKey', { fg = "fg" })
--- vim.api.nvim_set_hl(0, 'EndofBuffer', { fg = "bg" })
--- important
-- vim.api.nvim_set_hl(0, 'StatusLine', { bg = "bg" })
-- vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = "bg" })
-- vim.api.nvim_set_hl(0, 'Comment', { gui = false })
-- vim.api.nvim_set_hl(0, 'Error', { fg = "#ffffff", undercurl = true })
-- vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })
-- vim.api.nvim_set_hl(0, 'EndofBuffer', { fg = "#5c6370" })
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true })
-- vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { bg = "lightgrey" })
-- vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { bg = "lightgrey" })
--
-- hi link StatusLine VertSplit
-- hi link StatusLineNC VertSplit
-- vim.cmd([[hi StatusLine guibg=guibg guifg=#3b3f4c]])
-- vim.cmd([[hi StatusLineNC guibg=guibg guifg=#3b3f4c]])

-- vim.cmd([[
--   set statusline=%{repeat('─',winwidth('.'))}
-- ]])
-- set statusline=%{repeat('─',winwidth('.'))}

vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  -- vert = "|",
  -- stlnc = "─",
  -- stl = "─",
  -- stl = "",
  -- stl = "─",
  -- stl = "─",
  -- stlnc = "─",
  horizup = "┴",
  -- horiz = "-"
}
-- vim.api.nvim_set_hl(0, 'StatusLine', { bg = "bg", fg="#3b3f4c"})
-- vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = "bg", fg="#3b3f4c"})

-- hi link StatusLineNC VertSplit

-- if vim.g.neovide then
--   vim.o.guifont = "Hack"
--   vim.opt.linespace = 1
--   vim.g.transparency = 0.5
--   vim.g.neovide_scroll_animation_length = 0
--   vim.g.neovide_hide_mouse_when_typing = true
--   vim.g.neovide_refresh_rate = 100
--   vim.g.neovide_cursor_animation_length = 0
-- end

-- Slightly modified from :h setting-tabline:
vim.cmd([[
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

" set tabline=%!MyTabLine()
]])


vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod = 'expr'
vim.o.foldlevelstart = 999
