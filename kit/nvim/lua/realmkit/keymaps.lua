local map = vim.keymap.set
map("i", "jk", "<Esc>", { desc = "Leave insert mode" })
map("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlight" })
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
