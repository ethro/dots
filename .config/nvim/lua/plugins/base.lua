-- kanagawa ----------------------------
local kanagawa = require("kanagawa")

kanagawa.setup({
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
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
-- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "yellow" })
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = "pink" })
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { bg = "black" })

-- oil ---------------------------------
local oil = require("oil")

oil.setup({
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  win_options = {
    signcolumn = "yes:2",
  },
  watch_for_chagnes = true,
  keymaps = {
    Yp = {
      callback = function()
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
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
        local prefills = { paths = oil.get_current_dir() }

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

vim.keymap.set("n", "<leader>ov", ":vsplit %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil vsplit" })
vim.keymap.set("n", "<leader>os", ":split %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil split" })
vim.keymap.set("n", "<leader>ot", ":tabe %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil tabe" })
vim.keymap.set("n", "<leader>oo", ":Oil<CR>", { desc = "Open Oil" })
vim.keymap.set("n", "<leader>of", ':lua require("oil").open_float()<CR>', { desc = "Open Oil float" })

-- grug-far ----------------------------
local grug_far = require("grug-far")
vim.keymap.set(
  "n",
  "<leader>Sw",
  ":lua require('grug-far').open({ transient = true, prefills = { search = vim.fn.expand(\"<cword>\") } })<cr>",
  { desc = "Grug Current Word" }
)
vim.keymap.set(
  "n",
  "<leader>SW",
  ':lua require(\'grug-far\').open({ transient = true, prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>")  } })<cr>',
  { desc = "Grug Current Word in file" }
)

-- which-key ---------------------------
local which_key = require("which-key")
which_key.setup({
  preset = "modern",
})
vim.keymap.set("n", "<leader>?", function()
  which_key.show({ global = true })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- statusline --------------------------
require("mini.statusline").setup({})

-- persistence -------------------------
local persistence = require("persistence")

persistence.setup({
  options = vim.opt.sessionoptions:get(),
})

vim.keymap.set("n", "<leader>qs", function()
  persistence.load()
end, { desc = "Restore Session" })
vim.keymap.set("n", "<leader>qS", function()
  persistence.select()
end, { desc = "Select Session" })
vim.keymap.set("n", "<leader>ql", function()
  persistence.load({ last = true })
end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>qL", function()
  persistence.list()
end, { desc = "List Sessions" })
vim.keymap.set("n", "<leader>qd", function()
  persistence.stop()
end, { desc = "Don't Save Current Session" })
vim.keymap.set("n", "<leader>qc", function()
  persistence.save()
end, { desc = "Save Current Session" })

-- showkeys ----------------------------
local showkeys = require("showkeys")
showkeys.setup({
  timeout = 1,
  maxkeys = 5,
  position = "bottom-right",
})

vim.keymap.set("n", "<leader>uk", ":ShowkeysToggle<CR>", { desc = "Toggle showkeys" })
