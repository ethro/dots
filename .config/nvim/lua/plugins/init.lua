vim.pack.add({
  -- File navigation
  "https://github.com/stevearc/oil.nvim",

  -- Appearance
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/m4xshen/smartcolumn.nvim", -- review
  "https://github.com/echasnovski/mini.statusline",
  "https://github.com/nvzone/showkeys",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/xzbdmw/colorful-menu.nvim",
  -- "https://github.com/nvim-lualine/lualine.nvim", -- review

  -- LSP, completion, and formatting
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/Saghen/blink.lib",
  "https://github.com/Saghen/blink.cmp",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/rachartier/tiny-code-action.nvim",
  "https://github.com/rmagatti/logger.nvim",
  "https://github.com/rmagatti/goto-preview",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",

  -- Syntax and editing
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- Diagnostics and command line
  -- "https://github.com/rachartier/tiny-cmdline.nvim", -- review
  "https://github.com/stevearc/quicker.nvim", -- review
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/artemave/workspace-diagnostics.nvim",

  -- Git, diff
  "https://github.com/martindur/zdiff.nvim", -- review
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",

  -- Testing
  "https://github.com/nvim-lua/plenary.nvim",

  -- Developer utilities
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/arborist-ts/arborist.nvim",
  "https://github.com/chrisgrieser/nvim-chainsaw",
  "https://github.com/folke/persistence.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/stevearc/overseer.nvim",

  -- Debug
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/mfussenegger/nvim-dap-python",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/theHamsta/nvim-dap-virtual-text",

  -- Extras
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/FabijanZulj/blame.nvim",
  "https://github.com/RaafatTurki/hex.nvim",
  "https://github.com/cappyzawa/trim.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/chrisgrieser/nvim-scissors",
  "https://github.com/danymat/neogen",
  "https://github.com/folke/styler.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/marko-cerovac/material.nvim",
  "https://github.com/mofiqul/dracula.nvim",
  "https://github.com/sbulav/nredir.nvim",
  "https://github.com/sho-87/kanagawa-paper.nvim",

  -- To review ---------------------------------------------------------------
  -- File navigation
  -- "https://github.com/nvim-telescope/telescope.nvim",
  -- "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  -- "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  -- "https://github.com/nvim-telescope/telescope-frecency.nvim",

  -- Appearance

  -- LSP, completion, and formatting
  -- "https://github.com/b0o/SchemaStore.nvim",

  -- Testing
  -- "https://github.com/nvim-neotest/neotest",
  -- "https://github.com/nvim-neotest/nvim-nio",
  -- "https://github.com/antoinemadec/FixCursorHold.nvim",
  -- "https://github.com/fredrikaverpil/neotest-golang",

  -- Go tools
  -- "https://github.com/fredrikaverpil/godoc.nvim",
  -- "https://github.com/olexsmir/gopher.nvim",
})

require("plugins.base")
require("plugins.dev")
require("plugins.dap")
require("plugins.extras")
