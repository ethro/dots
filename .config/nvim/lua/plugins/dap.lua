-- nvim-dap-ui -------------------------
local _dap, dapui = require("dap"), require("dapui")
dapui.setup({})
_dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
_dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
_dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
_dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle({})
end, { desc = "Dap UI" })

-- bash
local bash_db_dap_bin = vim.fn.stdpath("data") .. "/mason/bin/bash-debug-adapter"
local _bashdb_dir = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir"
_dap.configurations.sh = {
  {
    name = "Launch bash debugger",
    type = "sh",
    request = "launch",
    program = "${file}",
    cwd = "${fileDirname}",
    pathBashdb = _bashdb_dir .. "/bashdb",
    pathBashdbLib = _bashdb_dir,
    pathBash = "bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    env = {},
    args = {},
    -- showDebugOutput = true,
    -- trace = true,
  },
}
_dap.adapters.sh = {
  type = "executable",
  command = "bash-debug-adapter",
}
-- NOTE: Resources:
-- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
_dap.adapters.lldb = {
  id = "lldb",
  type = "executable",
  command = "codelldb",
}
-- NOTE: Resources
-- https://code.visualstudio.com/docs/cpp/launch-json-reference
_dap.adapters.cpptools = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7",
}
-- _dap.configurations.cpp = {
--   {
--     name = "Launch file",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtEntry = true,
--   },
--   setupCommands = { -- This allows vectors and other data structures(STL containers) to show the values inside them.
--     {
--       text = "-enable-pretty-printing",
--       description = "enable pretty printing",
--       ignoreFailures = false,
--     },
--   },
--   {
--     name = "Launch Current File",
--     type = "cppdbg",
--     request = "launch",
--     program = function()
--       -- Get the current file's name without the .cpp extension
--       local executable = vim.fn.expand("%:p:r")
--       -- Check if the executable exists
--       if vim.fn.filereadable(executable) == 1 then
--         return executable
--       else
--         vim.notify("Executable not found: " .. executable, vim.log.levels.ERROR)
--         return nil
--       end
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtEntry = true,
--     setupCommands = { -- This allows vectors and other data structures(STL containers) to show the values inside them.
--       {
--         text = "-enable-pretty-printing",
--         description = "enable pretty printing",
--         ignoreFailures = false,
--       },
--     },
--   },
-- }
--

require("dap-python").setup("uv")
require("nvim-dap-virtual-text").setup({})

vim.keymap.set("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue" })
vim.keymap.set("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into", nowait = true, remap = false })
vim.keymap.set("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over", nowait = true, remap = false })
vim.keymap.set("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Step Out", nowait = true, remap = false })
vim.keymap.set("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL", nowait = true, remap = false })
vim.keymap.set("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last", nowait = true, remap = false })
vim.keymap.set("n", "<leader>dq", function()
  require("dap").terminate()
  require("dapui").close()
  require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate", nowait = true, remap = false })
vim.keymap.set("n", "<leader>dB", function()
  require("dap").list_breakpoints()
end, { desc = "List Breakpoints", nowait = true, remap = false })
vim.keymap.set("n", "<leader>de", function()
  require("dap").set_exception_breakpoints({ "all" })
end, { desc = "Set Exception Breakpoints", nowait = true, remap = false })
