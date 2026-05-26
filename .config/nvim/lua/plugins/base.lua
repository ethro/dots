return {
  {
    "rebelot/kanagawa.nvim",
    branch = "master",
    config = function()
      require("kanagawa").setup({
        transparent = true,
        overrides = function(_)
          return {
            ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
            ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
            ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
            ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
            ["@markup.list.markdown"] = { link = "Function" }, -- + list
            ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
            ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
          }
        end,
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MagicDuck/grug-far.nvim",
    },
    config = function()
      local _oil = require("oil")
      _oil.setup({
        default_file_explorer = true,
        keymaps = {
          Yp = {
            callback = function()
              local entry = _oil.get_cursor_entry()
              local dir = _oil.get_current_dir()
              if not entry or not dir then
                return
              end
              local relpath = vim.fn.fnamemodify(dir, ":.")
              vim.fn.setreg("+", relpath .. entry.name)
            end,
            desc = "Copy the path of the file under the cursor to the + register.",
          },
          gs = {
            callback = function()
              -- get the current directory
              local prefills = { paths = _oil.get_current_dir() }

              local grug_far = require("grug-far")
              -- instance check
              if not grug_far.has_instance("explorer") then
                grug_far.open({
                  instanceName = "explorer",
                  prefills = prefills,
                  staticTitle = "Find and Replace from Explorer",
                })
              else
                grug_far.get_instance("explorer"):open()
                -- updating the prefills without clearing the search and other fields
                grug_far.get_instance("explorer"):update_input_values(prefills, false)
              end
            end,
            desc = "oil: Search in directory",
          },
        },
        view_options = {
          show_hidden = true,
        },
      })
      local kmap = vim.keymap.set
      kmap("n", "<leader>ov", ":vsplit %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil vsplit" })
      kmap("n", "<leader>os", ":split %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil split" })
      kmap("n", "<leader>ot", ":tabe %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil tabe" })
      kmap("n", "<leader>oo", ":Oil<CR>", { desc = "Open Oil" })
      kmap("n", "<leader>of", ':lua require("oil").open_float()<CR>', { desc = "Open Oil float" })
    end,
    -- Optional dependencies
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    keys = {
      {
        "<leader>Sw",
        ":lua require('grug-far').open({ transient = true, prefills = { search = vim.fn.expand(\"<cword>\") } })<cr>",
        desc = "Grug Current Word",
      },
      {
        "<leader>SW",
        ':lua require(\'grug-far\').open({ transient = true, prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>")  } })<cr>',
        desc = "Grug Current Word in file",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "echasnovski/mini.statusline",
    opts = {},
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      -- stylua: ignore start
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session", },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select Session", },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session", },
      { "<leader>qL", function() require("persistence").list() end, desc = "List Sessions", },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session", },
      { "<leader>qc", function() require("persistence").save() end, desc = "Save Current Session", },
      -- stylua: ignore end
    },
  },
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "bottom-right",
    },
    keys = {
      { "<leader>uk", ":ShowkeysToggle<CR>", { desc = "Toggle showkeys" } },
    },
  },
}
