-- Keymaps para gitsigns
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts)