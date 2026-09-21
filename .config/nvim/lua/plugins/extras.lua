-- nredir ------------------------------
require("nredir").setup({})
-- trim --------------------------------
require("trim").setup({
  ft_blocklist = { "markdown" },
  trim_on_write = true,
  trim_trailing = true,
  trim_last_line = true,
  trim_first_line = true,
})
-- neogen ------------------------------
require("neogen").setup({})
vim.keymap.set("n", "<leader>cg", ":lua require('neogen').generate()<CR>", { desc = "Neogen generate", noremap = true, silent = true })
-- hex ---------------------------------
require("hex").setup({})
-- scissors ----------------------------
require("scissors").setup({
  snippetDir = vim.fn.stdpath("config") .. "/snippets",
})
vim.keymap.set("n", "<leader>se", function()
  require("scissors").editSnippet()
end, { desc = "Snippet: Edit" })

vim.keymap.set(
  { "n", "x" }, -- when used in visual mode, prefills the selection as snippet body
  "<leader>sa",
  function()
    require("scissors").addNewSnippet()
  end,
  { desc = "Snippet: Add" }
)

local zk = require("zk")
zk.setup({
  picker = "snacks_picker",
  picker_options = {
    snacks_picker = {
      layout = {
        preset = "ivy",
      },
    },
  },
})

---Opens a notes picker, and edits the selected notes
--
---@param options? table additional options
---@param picker_options? table options for the picker
---@see https://github.com/zk-org/zk/blob/main/docs/tips/editors-integration.md#zklist
---@see zk.ui.pick_notes
function zk.my_edit(options, picker_options)
  zk.pick_notes(options, picker_options, function(notes)
    if picker_options and picker_options.multi_select == false then
      notes = { notes }
    end

    for _, note in ipairs(notes) do
      if options and options.view then
        if options.view == "vertical" then
          vim.cmd("vsplit " .. note.absPath)
        elseif options.view == "horizontal" then
          vim.cmd("split " .. note.absPath)
        elseif options.view == "tab" then
          vim.cmd("tabe " .. note.absPath)
        end
      else
        vim.cmd("e " .. note.absPath)
      end
    end
  end)
end

local zk_commands = require("zk.commands")

zk_commands.add("ZkEdit", function(options)
  zk.my_edit(options, { title = "Zk Edit" })
end)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function(args)
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local in_frontmatter = false

    for i, line in ipairs(lines) do
      if line:match("^%-%-%-$") then
        if not in_frontmatter then
          in_frontmatter = true
        else
          break
        end
      elseif in_frontmatter and line:match("^modified:%s") then
        local new_line = "modified: " .. os.date("%Y-%m-%d %H:%M")
        vim.api.nvim_buf_set_lines(args.buf, i - 1, i, false, { new_line })
        return
      end
    end
  end,
})

local opts = { noremap = true, silent = false }

-- Create a new note after asking for its title.
-- vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkEdit { sort = { 'modified' } }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zO", "<Cmd>ZkEdit<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zv", "<Cmd>ZkEdit { view = 'vertical', sort = { 'modified' } }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zh", "<Cmd>ZkEdit { view = 'horizontal', sort = { 'modified' } }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zT", "<Cmd>ZkEdit { view = 'tab', sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

-- quicker -----------------------------
require("quicker").setup({})
