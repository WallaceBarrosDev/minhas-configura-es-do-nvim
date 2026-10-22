-- Keymaps para telescope
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)
map("n", "<leader>fr", builtin.oldfiles, opts)