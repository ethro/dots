require("vim._core.ui2").enable({})

vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    prefix = "●",
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true -- enable 24-bit colors
vim.o.swapfile = false
vim.o.backup = false
vim.o.autoread = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = false

vim.o.completeopt = "noinsert,preview,fuzzy" -- omnicomplete options for popup menu
-- vim.o.pumheight = 6 -- max height of completion menu
vim.o.winborder = "rounded" -- rounded border
vim.o.showmode = false -- disable showing mode below statusline

vim.o.cursorline = true -- enable cursor line
vim.o.signcolumn = "yes" -- always show sign column
vim.o.ignorecase = true -- case-insensitive search
vim.o.smartcase = true -- until search pattern contains upper case characters
vim.o.incsearch = true -- enable highlighting search in progress

vim.o.tabstop = 4 -- how many spaces tab inserts
vim.o.softtabstop = 4 -- how many spaces tab inserts
vim.o.shiftwidth = 4 -- controls number of spaces when using >> or << commands
vim.o.expandtab = true -- use appropriate number of spaces with tab
vim.o.smartindent = true -- indenting correctly after {
vim.o.autoindent = true -- copy indent from current line when starting new line
vim.o.scrolloff = 4 -- always keep 8 lines above/below cursor unless at start/end of file

vim.o.splitbelow = true -- better splitting
vim.o.splitright = true -- better splitting

vim.o.wrap = false -- disable wrapping
vim.o.breakindent = true -- prevent line wrapping
-- vim.opt.fillchars = { vert = " " } -- remove line divider between splits
vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3 -- global statusline

-- opt.autocomplete = false
-- opt.breakindent = true
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.colorcolumn = "80"
-- opt.completeopt = "menu,menuone,noinsert,popup,preview,fuzzy"
-- opt.confirm = true
-- opt.cursorline = true
-- opt.cursorlineopt = "number"
-- opt.diffopt = "iwhite,filler"
-- opt.expandtab = true
-- -- opt.foldmethod = "syntax"
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.ignorecase = true
-- opt.number = true
-- -- opt.pumblend = 0
-- -- opt.pumheight = 15
-- opt.relativenumber = false
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- opt.shiftround = true
-- opt.shiftwidth = 4
-- opt.showbreak = "↪"
-- opt.showmode = false
-- opt.signcolumn = "number" -- was "yes" review after use
-- opt.smartindent = true
-- opt.splitbelow = true
-- opt.splitkeep = "screen"
-- opt.splitright = true
-- opt.swapfile = false
-- opt.tabstop = 4
-- opt.termguicolors = true
-- opt.timeoutlen = 300
-- opt.undofile = true
-- opt.undofile = true
-- opt.laststatus = 3
-- opt.undolevels = 2000
-- opt.virtualedit = "block"
-- -- opt.wildmode = "longest:full,full" -- review after a while
-- opt.wrap = false
-- opt.updatetime = 300
--
-- -- TODO: revisit
-- opt.conceallevel = 0
-- opt.list = true
-- -- Helper for Snacks, lualine
-- vim.g.have_nerd_font = true
--
-- -- Disable unused providers
-- vim.g.loaded_npm_provider = 0
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- opt.foldtext = ""
-- opt.foldlevelstart = 99
-- -- TODO: optionally set to rg based on whether it's avaialable?
-- -- opt.grepprg = "rg --json"
-- -- opt.formatexpr = "v:lua.require'az.utils'.format.formatexpr()"
-- -- opt.shortmess:append({ W = true, c = true, C = true })
--
-- -- What does root_spec do? LazyVim command that shows info about the root dir detection
-- -- TODO: review desired setup, sometimes I end up with what I don't want as the root
-- vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
--
-- -- TODO: Review
-- -- vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
-- --
-- -- TODO: Need to understand how this affects lsp formatting/conform
-- -- vim.g.autoformat = true
