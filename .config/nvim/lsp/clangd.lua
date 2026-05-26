return {
  cmd = {
    "clangd",
    "--log=error",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--limit-references=5000",
    "--limit-results=500",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = false,
    clangdFileStatus = true,
  },

}
