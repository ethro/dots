return {
  {
    "marko-cerovac/material.nvim",
    "mofiqul/dracula.nvim",
    "sho-87/kanagawa-paper.nvim",
    "EdenEast/nightfox.nvim",
    "folke/tokyonight.nvim",
    "catppuccin/nvim",
  },
  {
    -- Easy configuration for trimming trailing whitespace and lines
    -- https://github.com/cappyzawa/trim.nvim
    "cappyzawa/trim.nvim",
    lazy = true,
    config = function()
      local trim = require("trim")

      trim.setup({
        ft_blocklist = { "markdown" },
        trim_on_write = true,
        trim_trailing = true,
        trim_last_line = true,
        trim_first_line = true,
      })
    end,
  },
  {
    -- TODO: add support for different doxygen types (i.e. c vs c++)
    -- Has a dependency on treesitter... need a new solution now that nvim-treesitter
    -- is dead.
    "danymat/neogen",
    enabled = true,
    config = true,
    priority = 10,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
    keys = {
      { "<leader>cg", ":lua require('neogen').generate()<CR>", desc = "Neogen generate", noremap = true, silent = true },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "FabijanZulj/blame.nvim" },
  {
    "RaafatTurki/hex.nvim",
    opts = {},
  },
  {
    -- https://github.com/chrisgrieser/nvim-scissors
    -- Automagical editing and creation of snippets.
    "chrisgrieser/nvim-scissors",
  },
  -- {
  -- -- Snippet Courtesy of @Zeioth,
  --   "L3MON4D3/LuaSnip",
  --   build = vim.fn.has "win32" ~= 0 and "make install_jsregexp" or nil,
  --   dependencies = {
  --     "benfowler/telescope-luasnip.nvim",
  --   },
  --   config = function(_, opts)
  --     if opts then require("luasnip").config.setup(opts) end
  --     vim.tbl_map(
  --       function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
  --       { "vscode", "snipmate", "lua" }
  --     )
  --     -- friendly-snippets - enable standardized comments snippets
  --     -- require("luasnip").filetype_extend("typescript", { "tsdoc" })
  --     -- require("luasnip").filetype_extend("javascript", { "jsdoc" })
  --     require("luasnip").filetype_extend("lua", { "luadoc" })
  --     require("luasnip").filetype_extend("python", { "pydoc" })
  --     require("luasnip").filetype_extend("rust", { "rustdoc" })
  --     -- require("luasnip").filetype_extend("cs", { "csharpdoc" })
  --     require("luasnip").filetype_extend("c", { "cdoc" })
  --     require("luasnip").filetype_extend("cpp", { "cppdoc" })
  --     require("luasnip").filetype_extend("sh", { "shelldoc" })
  --   end,
  -- },
}
--[[
return {
  {
    "folke/styler.nvim",
    config = function()
      require("styler").setup({
        themes = {
          markdown = { colorscheme = "material-darker", background = "dark" },
          help = { colorscheme = "kanagawa", background = "dark" },
        },
      })
    end,
  },
}
--]]
