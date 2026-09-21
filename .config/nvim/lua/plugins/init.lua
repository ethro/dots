local gh = function(x)
  return "https://github.com/" .. x
end

vim.pack.add({
  -- File navigation
  gh("stevearc/oil.nvim"),

  -- Appearance
  gh("rebelot/kanagawa.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("folke/which-key.nvim"),
  gh("m4xshen/smartcolumn.nvim"), -- review
  gh("echasnovski/mini.statusline"),
  gh("nvzone/showkeys"),
  gh("folke/todo-comments.nvim"),
  gh("xzbdmw/colorful-menu.nvim"),
  -- gh("nvim-lualine/lualine.nvim"), -- review

  -- LSP, completion, and formatting
  gh("L3MON4D3/LuaSnip"),
  gh("Saghen/blink.lib"),
  gh("Saghen/blink.cmp"),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  gh("mason-org/mason-lspconfig.nvim"),
  gh("mason-org/mason.nvim"),
  gh("mikavilpas/blink-ripgrep.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("rachartier/tiny-code-action.nvim"),
  gh("rmagatti/logger.nvim"),
  gh("rmagatti/goto-preview"),
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),

  -- Syntax and editing
  gh("nvim-treesitter/nvim-treesitter"),

  -- Diagnostics and command line
  -- gh("rachartier/tiny-cmdline.nvim"), -- review
  gh("stevearc/quicker.nvim"), -- review
  gh("j-hui/fidget.nvim"),
  gh("artemave/workspace-diagnostics.nvim"),

  -- Git, diff
  gh("martindur/zdiff.nvim"), -- review
  gh("lewis6991/gitsigns.nvim"),
  gh("sindrets/diffview.nvim"),

  -- Testing
  gh("nvim-lua/plenary.nvim"),

  -- Developer utilities
  gh("MagicDuck/grug-far.nvim"),
  gh("arborist-ts/arborist.nvim"),
  gh("chrisgrieser/nvim-chainsaw"),
  gh("folke/persistence.nvim"),
  gh("folke/snacks.nvim"),
  gh("folke/trouble.nvim"),
  gh("stevearc/overseer.nvim"),

  -- Debug
  gh("mfussenegger/nvim-dap"),
  gh("mfussenegger/nvim-dap-python"),
  gh("nvim-neotest/nvim-nio"),
  gh("rcarriga/nvim-dap-ui"),
  gh("theHamsta/nvim-dap-virtual-text"),

  -- Extras
  gh("EdenEast/nightfox.nvim"),
  gh("FabijanZulj/blame.nvim"),
  gh("RaafatTurki/hex.nvim"),
  gh("cappyzawa/trim.nvim"),
  gh("catppuccin/nvim"),
  gh("chrisgrieser/nvim-scissors"),
  gh("danymat/neogen"),
  gh("folke/styler.nvim"),
  gh("folke/tokyonight.nvim"),
  gh("marko-cerovac/material.nvim"),
  gh("mofiqul/dracula.nvim"),
  gh("sbulav/nredir.nvim"),
  gh("sho-87/kanagawa-paper.nvim"),

  -- To review ---------------------------------------------------------------
  gh("zk-org/zk-nvim"),

  -- File navigation
  -- gh("nvim-telescope/telescope.nvim"),
  -- gh("nvim-telescope/telescope-fzf-native.nvim"),
  -- gh("nvim-telescope/telescope-ui-select.nvim"),
  -- gh("nvim-telescope/telescope-frecency.nvim"),

  -- Appearance

  -- LSP, completion, and formatting
  -- gh("b0o/SchemaStore.nvim"),

  -- Testing
  -- gh("nvim-neotest/neotest"),
  -- gh("nvim-neotest/nvim-nio"),
  -- gh("antoinemadec/FixCursorHold.nvim"),
  -- gh("fredrikaverpil/neotest-golang"),

  -- Go tools
  -- gh("fredrikaverpil/godoc.nvim"),
  -- gh("olexsmir/gopher.nvim"),
})

require("plugins.base")
require("plugins.dev")
require("plugins.dap")
require("plugins.extras")
