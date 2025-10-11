vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- close nvim-tree if it's last buffer open
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == 'NvimTree' then
      vim.cmd 'quit'
    end
  end,
})

-- linting when file is written to
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype, on write
    require('lint').try_lint()
  end,
})

-- spellcheck in md
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  command = 'setlocal spell wrap',
})

-- disable automatic comment on newline
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- restore cursor pos on file open
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' then
      vim.cmd 'normal! g\'"'
    end
  end,
})

-- startup time
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    vim.g.startup_time_ms = string.format('%.2f ms', startuptime * 1000)
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = '*',
  group = augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
        vim.cmd 'redraw'
      end
    end
  end,
})
