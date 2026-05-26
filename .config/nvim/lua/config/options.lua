local opt = vim.opt

opt.autocomplete = false
opt.breakindent = true
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.colorcolumn = "80"
opt.completeopt = "menu,menuone,noinsert,popup,preview,fuzzy"
opt.confirm = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.diffopt = "iwhite,filler"
opt.expandtab = true
-- opt.foldmethod = "syntax"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.ignorecase = true
opt.number = true
-- opt.pumblend = 0
-- opt.pumheight = 15
opt.relativenumber = false
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 4
opt.showbreak = "↪"
opt.showmode = false
opt.signcolumn = "number" -- was "yes" review after use
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undofile = true
opt.laststatus = 3
opt.undolevels = 2000
opt.virtualedit = "block"
-- opt.wildmode = "longest:full,full" -- review after a while
opt.wrap = false
opt.updatetime = 300

-- TODO: revisit
opt.conceallevel = 0
opt.list = true
-- Helper for Snacks, lualine
vim.g.have_nerd_font = true

-- Disable unused providers
vim.g.loaded_npm_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
opt.foldtext = ""
opt.foldlevelstart = 99
-- TODO: optionally set to rg based on whether it's avaialable?
-- opt.grepprg = "rg --json"
-- opt.formatexpr = "v:lua.require'az.utils'.format.formatexpr()"
-- opt.shortmess:append({ W = true, c = true, C = true })

-- What does root_spec do? LazyVim command that shows info about the root dir detection
-- TODO: review desired setup, sometimes I end up with what I don't want as the root
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- TODO: Review
-- vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
--
-- TODO: Need to understand how this affects lsp formatting/conform
-- vim.g.autoformat = true
