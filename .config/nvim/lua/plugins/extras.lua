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
