local u = require("utils")

vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.number = true
-- vim.opt.foldcolumn = '1' -- '0' is not bad
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldenable = true
vim.opt.numberwidth = 2
-- vim.opt.ruler = false
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400
vim.opt.undofile = true
vim.opt.equalalways = true

local opts = { noremap = true, silent = true }

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", u.merge({ desc = "Navigate pane up" }, opts))
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", u.merge({ desc = "Navigate pane down" }, opts))
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", u.merge({ desc = "Navigate pane left" }, opts))
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", u.merge({ desc = "Navigate pane right" }, opts))
vim.keymap.set("n", "<c-s>", "<cmd> w <CR>", u.merge({ desc = "Save buffer" }, opts))
vim.keymap.set("i", "<c-s>", "<esc>:w <CR>", u.merge({ desc = "Save buffer" }, opts))

vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", u.merge({ desc = "Move selection up" }, opts))
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", u.merge({ desc = "Move selection down" }, opts))
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", u.merge({ desc = "Move selection up" }, opts))
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", u.merge({ desc = "Move selection down" }, opts))
vim.keymap.set("n", "<C-_>", ":WhichKey<CR>", u.merge({ desc = "Open WhichKey" }, opts))
vim.keymap.set("v", "<C-_>", ":WhichKey<CR>", u.merge({ desc = "Open WhichKey" }, opts))
vim.keymap.set("i", "<C-_>", ":WhichKey<CR>", u.merge({ desc = "Open WhichKey" }, opts))
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", u.merge({ desc = "Clear highlight" }, opts))
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", u.merge({ desc = "Escape terminal mode" }, opts))

-- disabling page up and page down for keyboards that have it near the arrow keys
vim.keymap.set({ 'n', 'i', 'v' }, '<PageUp>', '<Nop>')
vim.keymap.set({ 'n', 'i', 'v' }, '<PageDown>', '<Nop>')

-- For jumping forwards in the quickfix list
vim.keymap.set("n", "]q", function()
  local count = vim.v.count1 -- Default to 1 if no count is given
  vim.cmd(count .. "cnext")
end, u.merge({ desc = "Next quicklist item" }, opts))

-- For jumping backwards in the quickfix list
vim.keymap.set("n", "[q", function()
  local count = vim.v.count1 -- Default to 1 if no count is given
  vim.cmd(count .. "cprev")
end, u.merge({ desc = "Prev quicklist item" }, opts))

vim.wo.number = true
vim.api.nvim_command("command! -nargs=* Qa qa<args>")

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#303030" })
