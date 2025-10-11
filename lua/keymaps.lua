local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- better copy paste
map('n', 'x', '"_x')
map('n', '<Leader>p', '"0p')
map('n', '<Leader>P', '"0P')
map('v', '<Leader>p', '"0p')
map('n', '<Leader>c', '"_c')
map('n', '<Leader>C', '"_C')
map('v', '<Leader>c', '"_c')
map('v', '<Leader>C', '"_C')
map('n', '<Leader>d', '"_d')
map('n', '<Leader>D', '"_D')
map('v', '<Leader>d', '"_d')
map('v', '<Leader>D', '"_D')

-- increment/decrement
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- better navigation
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
--
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
--
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', '=', '=gv')

-- exit terminal mode
map('t', '<leader><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- select all
map('n', '<C-a>', 'ggVG', { desc = 'select all' })

-- windows
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- copilot
vim.keymap.set('n', '<leader>tc', ':Copilot disable<cr>', { silent = true, noremap = true, desc = 'Disable Copilot' })
vim.keymap.set('n', '<leader>tC', ':Copilot enable<cr>', { silent = true, noremap = true, desc = 'Enable Copilot' })

-- save file
map({ 'i', 'x', 'n', 's' }, '<A-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- new file
map('n', '<leader>ne', '<cmd>enew<cr>', { desc = 'New File' })

-- reset
map('n', '<leader>L', '<cmd>LspRestart<cr>')
map('n', '<Esc>', ':nohlsearch<CR>')
map('n', '<leader>cc', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / Clear hlsearch / Diff Update' })

-- toggles
map('n', '<leader>tw', ':set wrap!<CR>', { desc = 'toggle wrap' }) --tggle wrap

map('n', '<leader>tr', function() --toggle relative vs absolute line numbers
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
  end
end, { desc = 'toggle relativenumber' })

map('n', '<leader>ts', function() --toggle spell check
  if vim.wo.spell then
    vim.wo.spell = false
  else
    vim.wo.spell = true
  end
end, { desc = 'toggle spell' })

-- shortcuts to open plugins
map('n', '<leader>L', '<cmd>Lazy<cr>', { desc = 'Lazy' })
map('n', '<leader>M', '<cmd>Mason<cr>', { desc = 'Mason' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- splits and buffers
map('n', '<leader>vs', ':vsplit<CR>:bnext<CR>') --ver split + open next buffer

-- diagnostic quick fix
map('n', '<leader>i', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- check spell
map('n', '<leader>k', 'z=', { desc = 'Check spell' })

-- quickfix navigation
map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- floating terminal
map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })
map('n', '<C-q>', '<cmd>w<cr>', { desc = 'Write' })
map('n', '<C-k>', '<cmd>q<cr>', { desc = 'Quit' })

-- tips out of the way
map('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'make file executable' })
map('n', '<leader>mv', ':!mv % ', { desc = 'move file to new place' })
map('n', '<leader>r', ':so %<CR>', { desc = 'soruce current file' })
map('n', '<leader>u', ':silent !xdg-open "<cWORD>" &<CR>', { desc = 'open a url under cursor' })
map('n', '<leader>ma', function() --quick make in dir of buffer
  local bufdir = vim.fn.expand '%:p:h'
  vim.cmd('lcd ' .. bufdir)
  vim.cmd '!sudo make uninstall && sudo make clean install %'
end)

-- location list
map('n', '<leader>xl', function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Location List' })

-- quickfix list
map('n', '<leader>xq', function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = 'Quickfix List' })
