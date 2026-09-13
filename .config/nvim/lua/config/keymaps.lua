vim.keymap.set("n", "<leader>uu", require("undotree").open, { desc = "Open Undotree" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local kmap = vim.keymap.set

-- Should be able to get the path from nvim vars...?
local nvim_conf = "~/.config/nvim/lua"
local tmux_conf = "~/.config/tmux/tmux.conf"
local bashrcd = "~/.bashrc.d/"
local g_gitconfig = "~/.gitconfig"

-- Edit common files
kmap("n", "<leader>en", ":tabedit" .. nvim_conf .. "<CR>", { desc = "Edit nvim.conf" })
kmap("n", "<leader>et", ":tabedit" .. tmux_conf .. "<CR>", { desc = "Edit tmux.conf" })
kmap("n", "<leader>eb", ":tabedit" .. bashrcd .. "<CR>", { desc = "Edit bashrc.d" })
kmap("n", "<leader>eg", ":tabedit" .. g_gitconfig .. "<CR>", { desc = "Edit global gitconfig" })

-- buffers
kmap("n", "<leader>bd", ":bd<CR>", { desc = "Buffer delete" })

-- Move Lines
kmap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
kmap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
kmap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
kmap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
kmap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
kmap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Saner behavior of j and k when wrapping
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Clear search with <esc>
kmap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
--
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
kmap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- windows
-- kmap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
kmap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- kmap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
-- kmap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- kmap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- kmap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
kmap("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })
kmap("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
kmap("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New Tab" })
kmap("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next Tab" })
kmap("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
kmap("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

kmap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
kmap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
-- kmap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- kmap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- -- lazy
-- kmap("n", "<leader>Ol", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Diagnostics -----------------------------------------------------------------
local diagnostic_goto = function(next, severity)
  local _count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = _count, severity = severity })
  end
end

kmap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
kmap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
kmap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
kmap("n", "]e", diagnostic_goto(true, vim.diagnostic.severity.ERROR), { desc = "Next Error" })
kmap("n", "[e", diagnostic_goto(false, vim.diagnostic.severity.ERROR), { desc = "Prev Error" })
kmap("n", "]w", diagnostic_goto(true, vim.diagnostic.severity.WARN), { desc = "Next Warning" })
kmap("n", "[w", diagnostic_goto(false, vim.diagnostic.severity.WARN), { desc = "Prev Warning" })

-- quit
kmap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
kmap("n", "<leader>qr", "<cmd>restart<cr>", { desc = "Restart" })

--[[

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
kmap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
kmap("n", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("x", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("o", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next search result" })
kmap("n", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
kmap("x", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })
kmap("o", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev search result" })

-- new file
kmap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

--]]
-- Look at putting in LSP attach mappings...
kmap("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition in vertical split" })

-- buffers
kmap("n", "<leader>bd", ":bd<CR>", { desc = "Buffer delete" })

-- To review -------------------------------------------------------------------
-- Disable Space bar since it will be used as the leader key
vim.keymap.set({ "n", "v" }, "<leader>", "<nop>", { desc = "Disable leader key default" })

-- -- Save and quit current file quicker
-- vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true, noremap = true, desc = "Save current file" })
-- vim.keymap.set({ "n", "t" }, "<leader>q", ":q<cr>", { silent = true, noremap = true, desc = "Quit current buffer" })

-- Navigate through buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

-- -- Center buffer when navigating up and down
-- vim.keymap.set("n", "<S-k>", "<C-u>zz", { desc = "Scroll up and center" })
-- vim.keymap.set("n", "<S-j>", "<C-d>zz", { desc = "Scroll down and center" })

-- Center buffer when progressing through search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Paste without replacing paste with what you are highlighted over
vim.keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without replacing register" })

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Open buffer to the right
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true, desc = "Vertical split" })

-- -- Move selection up and down
-- vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
-- vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Copy file path / selection reference for pasting into AI chats
local function copy_ref(opts)
  -- "%" is the current buffer's file name; ":." makes it relative to the cwd
  local path = vim.fn.expand("%:.")
  -- ref is what ends up in the clipboard; start with just the path
  local ref = path

  if opts.visual then
    -- '< and '> are only set after leaving visual mode, so read the live selection:
    -- "v" is the line where visual mode was started (the anchor)
    local start_line = vim.fn.line("v")
    -- "." is the line the cursor is on now (the moving end of the selection)
    local end_line = vim.fn.line(".")
    -- if the selection was made upward, swap so start is always the smaller line
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    -- append the range, e.g. "lua/config/keymaps.lua:1:23"
    ref = path .. ":" .. start_line .. ":" .. end_line
  end

  -- ask for an optional free-text note on the command line (Enter to skip)
  local note = vim.fn.input("Prompt (optional): ")
  if note ~= "" then
    -- append the note after the ref, separated by a space
    ref = ref .. " " .. note
  end

  -- write ref into the "+" register, which is the system clipboard
  vim.fn.setreg("+", ref)
  -- show a confirmation message with what was copied
  vim.notify("Copied: " .. ref)
end

-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
  copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })
