return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "vim", "Snacks" },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.api.nvim_get_runtime_file("", true) },
      },
    },
  },
}
