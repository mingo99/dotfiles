-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>sP", "<cmd>LazyExtras<cr>", { desc = "Search Extras Plugin" })

-- vim.keymap.del("n", "<C-/>")
-- vim.keymap.del("n", "<C-_>")
-- vim.keymap.set("n", "<C-/>", "<cmd>ToggleTerm<cr>", { desc = "Open Toggleterm" })
-- vim.keymap.set("n", "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Open Toggleterm" })
