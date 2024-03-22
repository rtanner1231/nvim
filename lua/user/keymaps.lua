local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("i","<C-s>q",'<C-o>:SuiteQL ShowTablePicker<cr>',opts)
keymap("i","<C-s>k",'<C-o>:SuiteQL ShowFieldPicker<cr>',opts)
keymap("i","<C-s>q",'<C-o>:SuiteQL ShowLastTableFieldPicker<cr>',opts)


-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-K>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--splits
-- keymap("n","<leader>vv",":vsplit<CR>",opts)
-- keymap("n","<leader>vh",":split<CR>",opts)
-- keymap("n","<leader>vc","<C-w>c",opts)
-- keymap("n","<leader>vo",":on<CR>",opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- Close current buffer
keymap("n", "<leader>b", ":close<CR>",opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
--keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
--keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
--keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
--keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
--keymap("t", "<C-h>", "<C-W><Left>", opts)
--keymap("t", "<C-j>", "<C-W><Down>", opts)
--keymap("t", "<C-j>", "<C-W><Up>", opts)
--keymap("t", "<C-l>", "<C-W><Right>", opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
keymap('n', '<leader>r', ":lua require('telescope.builtin').lsp_references()<cr>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Toggle reletive line numbers
keymap("n","<leader>l", ":set rnu!<cr>", opts)

--Open code actions
keymap("n","<leader>a",":CodeActionMenu<cr>",opts)

--git
keymap("n","<leader>[",":Gitsigns prev_hunk<cr>",opts)
keymap("n","<leader>]",":Gitsigns next_hunk<cr>",opts)
keymap("n","<leader>=",":Gitsigns preview_hunk<cr>",opts)

--navbuddy
keymap("n","<leader>n",":Navbuddy<cr>",opts)

--trouble
keymap("n","<leader>u",":TroubleToggle document_diagnostics<cr>",opts)

--suiteql
--keymap("n","<leader>ss",":FormatSingleSuiteQL<cr>",opts)
--keymap("n","<leader>sa",":FormatSuiteQL<cr>",opts)
