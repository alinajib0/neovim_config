vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.opt.listchars = {
  tab = '┆ ', -- Tab character (clear and distinct)
  trail = '•', -- Trailing spaces (subtle but visible)
  nbsp = '⍽', -- Non-breaking spaces
  extends = '⟩', -- Line extends beyond screen
  precedes = '⟨', -- Line continues before screen
  eol = '↴', -- End of line (optional)
  space = '·', -- Regular spaces (optional)
  conceal = '┊', -- Concealed text (optional)
}
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.copyindent = true
