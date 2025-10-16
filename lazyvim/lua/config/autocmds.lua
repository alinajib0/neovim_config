vim.api.nvim_create_augroup("MarkdownSpell", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "MarkdownSpell",
  pattern = { "markdown", "text", "gitcommit", "latex" }, -- Add other file types as needed
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en" -- Optional: Set spell check language
  end,
})
