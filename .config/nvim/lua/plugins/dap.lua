return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local ensure_installed = {
        "bash-debug-adapter",
        "codelldb",
        "cpptools",
        "debugpy",
      }
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      local dap = require("dap")

      -- bash
      local bash_db_dap_bin = vim.fn.stdpath("data") .. "/mason/bin/bash-debug-adapter"
      local _bashdb_dir = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir"
      dap.configurations.sh = {
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
      dap.adapters.sh = {
        type = "executable",
        command = "bash-debug-adapter",
      }
      -- NOTE: Resources:
      -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
      dap.adapters.lldb = {
        id = "lldb",
        type = "executable",
        command = "codelldb",
      }
      -- NOTE: Resources
      -- https://code.visualstudio.com/docs/cpp/launch-json-reference
      dap.adapters.cpptools = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
      }
      -- dap.configurations.cpp = {
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
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
        nowait = true,
        remap = false,
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
          require("dapui").close()
          require("nvim-dap-virtual-text").toggle()
        end,
        desc = "Terminate",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dB",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List Breakpoints",
        nowait = true,
        remap = false,
      },
      {
        "<leader>de",
        function()
          require("dap").set_exception_breakpoints({ "all" })
        end,
        desc = "Set Exception Breakpoints",
        nowait = true,
        remap = false,
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    -- lazy = true,
    config = function()
      require("dap-python").setup("uv")
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
