local map = vim.keymap.set

map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

map("n", "<C-a>", "gg<S-v>G")

map("n", "<leader>te", ":tabedit")
map("n", "<tab>", ":tabnext<Return>")
map("n", "<s-tab>", ":tabprev<Return>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")
