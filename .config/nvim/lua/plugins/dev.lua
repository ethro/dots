return {
  {
    "saghen/blink.cmp",
    version = "v1.10.2",
    dependencies = {
      "saghen/blink.lib",
      -- optional: provides snippets for the snippet source
      -- "rafamadriz/friendly-snippets",
    },
    -- build = function()
    --   -- build the fuzzy matcher, wait up to 60 seconds
    --   -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
    --   require("blink.cmp").build():wait(60000)
    -- end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "default" },

      signature = {
        enabled = true,
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true },
        menu = { auto_show = true },
        list = {
          selection = {
            auto_insert = true,
          },
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- (Default) list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = { default = { "lsp", "buffer", "path", "snippets" } },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"`
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "rust" },
    },
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      local _diffview = require("diffview")
      _diffview.setup({
        hooks = {
          view_enter = function(view)
            vim.cmd("colorscheme kanagawa")
          end,
          view_leave = function(view)
            vim.cmd("colorscheme kanagawa")
          end,
        },
      })
      local kmap = vim.keymap.set
      kmap("n", "<leader>Do", ":DiffviewOpen<CR>", { desc = "Diffview Open" })
      kmap("n", "<leader>Df", ":DiffviewToggleFiles<CR>", { desc = "Diffview Toggle Files" })
      kmap("n", "<leader>Dc", ":DiffviewClose<CR>", { desc = "Diffview Close" })
      kmap("n", "<leader>Dr", ":DiffviewRefresh<CR>", { desc = "Diffview Refresh" })
      kmap("n", "<leader>Dh", ":DiffviewFileHistory %<CR>", { desc = "Diffview File History" })
      kmap("n", "<leader>DH", ":DiffviewFileHistory<CR>", { desc = "Diffview File History" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function kmap(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        -- stylua: ignore start
        kmap("n", "]g", gs.next_hunk, "Next Hunk")
        kmap("n", "[g", gs.prev_hunk, "Prev Hunk")
        kmap({ "n", "v" }, "<leader>Gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        kmap({ "n", "v" }, "<leader>Gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        kmap("n", "<leader>GS", gs.stage_buffer, "Stage Buffer")
        kmap("n", "<leader>Gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        kmap("n", "<leader>GR", gs.reset_buffer, "Reset Buffer")
        kmap("n", "<leader>Gp", gs.preview_hunk, "Preview Hunk")
        kmap("n", "<leader>Gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        kmap("n", "<leader>GB", function() gs.blame({ full = true }) end, "Blame")
        kmap("n", "<leader>Gd", gs.diffthis, "Diff This")
        kmap("n", "<leader>GD", function() gs.diffthis("~") end, "Diff This ~")
        kmap({ "o", "x" }, "<leader>Gh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        -- stylua: ignore end
      end,
    },
  },
  {
    "rmagatti/goto-preview",
    dependencies = {
      "rmagatti/logger.nvim",
    },
    opts = {
      default_mappings = true,
      resizing_mappings = true,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    -- NOTE: https://github.com/stevearc/overseer.nvim/tree/master
    -- https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md
    -- https://github.com/stevearc/overseer.nvim/blob/master/doc/extending_vscode.md
    "stevearc/overseer.nvim",
    opts = {},
    keys = {
      { "<leader>Oo", "<cmd>OverseerRun<cr>", desc = "OverseerRun" },
    },
  },
  {
    "arborist-ts/arborist.nvim",
    opts = {
      prefer_wasm = false,
      install_popular = false,
      update_cadence = "manual",
      ensure_installed = {
        "asm",
        "bash",
        "bitbake",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "csv",
        "devicetree",
        "diff",
        "disassembly",
        "dockerfile",
        "doxygen",
        "editorconfig",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "gpg",
        "http",
        "idl",
        "ini",
        "jq",
        "json",
        "json5",
        "kconfig",
        "linkerscript",
        "llvm",
        "lua",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "matlab",
        "mermaid",
        "ninja",
        "objc",
        "objdump",
        "powershell",
        "python",
        "regex",
        "requirements",
        "rust",
        -- "sql",
        "ssh_config",
        -- "sway",
        "tcl",
        "tmux",
        "todotxt",
        "toml",
        "tsv",
        "typescript",
        -- "typst",
        "udev",
        "vhdl",
        "xml",
        "yaml",
        "yang",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>Om", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = {
        check_outdated_packages_on_open = false,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local _conform = require("conform")
      local _formatters = {
        c = { "clang-format" },
        cmake = { "cmakelang" },
        cpp = { "clang-format" },
        json = { "clang-format" },
        lua = { "stylua" },
        -- markdown = { "prettierd" },
        -- python = { "isort", "black" },
        python = { "ruff" },
        sh = { "shfmt" },
        -- tcl = { "tclint" },
        -- ts = { "ts-standard" },
        vhdl = { "vsg" },
        yaml = { "yamlfmt" },
      }
      local ensure_formatters = {}
      for _, _form_list in pairs((_formatters or {})) do
        for _, __form in ipairs((_form_list or {})) do
          vim.list_extend(ensure_formatters, { __form })
        end
      end
      require("mason-tool-installer").setup({ ensure_installed = ensure_formatters })
      _conform.setup({
        formatters_by_ft = _formatters,
        formatters = {
          clang_format = {
            -- Use --style=file to look for .clang-format in the project
            -- Use fallback-style to specify what happens if no file is found
            prepend_args = { "--fallback-style=Microsoft" },
          },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })

      local kmap = vim.keymap.set
      kmap({ "n", "v" }, "<leader>cf", function()
        _conform.format()
      end, { desc = "Format" })

      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- FormatToggle! will toggle formatting just for this buffer
          if vim.b.disable_autoformat then
            vim.b.disable_autoformat = false
          else
            vim.b.disable_autoformat = true
          end
        else
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
          else
            vim.g.disable_autoformat = true
          end
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })

      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<CR>", { desc = "Toggle global formatting" })
      vim.keymap.set("n", "<leader>uF", "<cmd>FormatToggle!<CR>", { desc = "Toggle buffer formatting" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    -- event = "LazyFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        -- fish = { "fish" },
        python = { "mypy", "flake8", "pydocstyle", "vulture" },
        cmake = { "cmakelint" },
        -- lua = { "luacheck" },
        rst = { "rstcheck" },
        sh = { "shellcheck", "shellharden" },
        tcl = { "tclint" },
        yaml = { "yamllint" },
        vhdl = { "vsg" },
        -- ts = { "ts-standard" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      local _M = {}

      local ensure_linters = {}
      -- TODO: get gud at lua tables...
      for _, _linters in pairs((opts.linters_by_ft or {})) do
        for _, _linter in ipairs((_linters or {})) do
          vim.list_extend(ensure_linters, { _linter })
        end
      end
      for __lint, _ in pairs((opts.linters or {})) do
        vim.list_extend(ensure_linters, { __lint })
      end
      require("mason-tool-installer").setup({ ensure_installed = ensure_linters })

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function _M.debounce(ms, fn)
        local timer = vim.loop.new_timer()
        return function(...)
          local argv = { ... }
          if timer then
            timer:start(ms, 0, function()
              timer:stop()
              vim.schedule_wrap(fn)(unpack(argv))
            end)
          end
        end
      end

      function _M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          -- if not linter then
          --   Util.warn("Linter not found: " .. name, { title = "nvim-lint" })
          -- end
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = _M.debounce(200, _M.lint),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "basedpyright",
          "clangd",
          "docker-language-server",
          "harper-ls",
          "lua-language-server",
          "mpls",
          "ruff",
        },
      })

      -- Minimal configs for servers that need no custom settings.
      -- Enable servers; lsp/*.lua provides config tables for servers needing custom settings
      local enable_lsps = {
        "basedpyright",
        "clangd",
        "lua_ls",
        "docker_ls",
        "ruff",
        "mpls",
      }
      vim.lsp.enable(enable_lsps)

      -- Shared capabilities for all servers
      local original_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
      capabilities.positionEncodings = { "utf-8", "utf-16" }
      vim.lsp.config("mpls", {
        cmd = { "mpls", "--theme", "dark", "--enable-emoji", "--enable-footnotes", "--no-auto", "--port", "36417" },
      })
      vim.lsp.config("*", {
        flags = { debounce_text_changes = 200 },
        capabilities = capabilities,
      })

      -- LSP keymaps and inlay hints (runs once per buffer on attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("willis-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client then
            -- inlayHint
            if client:supports_method("textDocument/inlayHint") then
              map("<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end, "Toggle Inlay Hints")
            end

            if client:supports_method("textDocument/documentHighlight") then
              local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = true })
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
              })
            end
            -- Enable native LSP completion
            vim.lsp.completion.enable(true, event.data.client_id, event.buf, { autotrigger = true })
          end
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = false },
      bigfile = { enabled = true },
      bufdelete = { enabled = false },
      dashboard = {
        enabled = false,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
      -- debug = { enabled = false },
      -- dim = { enabled = false },
      explorer = { enabled = false },
      gh = { enabled = false },
      -- git = { enabled = false },
      gitbrowse = { enabled = false },
      image = { enabled = false },
      -- indent = { enabled = false },
      input = { enabled = true },
      -- keymap = { enabled = false },
      -- layout = { enabled = false },
      lazygit = { enabled = true },
      notifier = { enabled = true },
      notify = { enabled = false },
      picker = {
        enabled = true,
        layout = "ivy",
        formatters = {
          file = {
            truncate = 60,
          },
        },
      },
      profiler = { enabled = false },
      quickfile = { enabled = false },
      -- rename = { enabled = false },
      scope = { enabled = false },
      -- scratch = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      -- terminal = { enabled = false },
      -- toggle = { enabled = false },
      -- win = { enabled = false },
      words = { enabled = false },
      zen = { enabled = false },
    },
    keys = {
              -- stylua: ignore start
              -- Top Pickers & Explorer
              { "<leader><space>", function() Snacks.picker.smart() end,                                       desc = "Smart Find Files" },
              { "<leader>,",       function() Snacks.picker.buffers() end,                                     desc = "Buffers" },
              { "<leader>/",       function() Snacks.picker.grep() end,                                        desc = "Grep" },
              { "<leader>:",       function() Snacks.picker.command_history() end,                             desc = "Command History" },
              { "<leader>n",       function() Snacks.picker.notifications() end,                               desc = "Notification History" },
              -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
              -- find
              { "<leader>fb",      function() Snacks.picker.buffers() end,                                     desc = "Buffers" },
              { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,     desc = "Find Config File" },
              { "<leader>ff",      function() Snacks.picker.files() end,                                       desc = "Find Files" },
              { "<leader>fg",      function() Snacks.picker.git_files() end,                                   desc = "Find Git Files" },
              { "<leader>fp",      function() Snacks.picker.projects() end,                                    desc = "Projects" },
              { "<leader>fr",      function() Snacks.picker.recent() end,                                      desc = "Recent" },
              -- git
              { "<leader>gb",      function() Snacks.picker.git_branches() end,                                desc = "Git Branches" },
              { "<leader>gl",      function() Snacks.picker.git_log() end,                                     desc = "Git Log" },
              { "<leader>gL",      function() Snacks.picker.git_log_line() end,                                desc = "Git Log Line" },
              { "<leader>gs",      function() Snacks.picker.git_status() end,                                  desc = "Git Status" },
              { "<leader>gS",      function() Snacks.picker.git_stash() end,                                   desc = "Git Stash" },
              { "<leader>gd",      function() Snacks.picker.git_diff() end,                                    desc = "Git Diff (Hunks)" },
              { "<leader>gf",      function() Snacks.picker.git_log_file() end,                                desc = "Git Log File" },
              -- Grep
              { "<leader>sb",      function() Snacks.picker.lines() end,                                       desc = "Buffer Lines" },
              { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                desc = "Grep Open Buffers" },
              { "<leader>sg",      function() Snacks.picker.grep() end,                                        desc = "Grep" },
              { "<leader>sw",      function() Snacks.picker.grep_word() end,                                   desc = "Visual selection or word", mode = { "n", "x" } },
              -- search
              { '<leader>s"',      function() Snacks.picker.registers() end,                                   desc = "Registers" },
              { '<leader>s/',      function() Snacks.picker.search_history() end,                              desc = "Search History" },
              { "<leader>sa",      function() Snacks.picker.autocmds() end,                                    desc = "Autocmds" },
              { "<leader>sb",      function() Snacks.picker.lines() end,                                       desc = "Buffer Lines" },
              { "<leader>sc",      function() Snacks.picker.command_history() end,                             desc = "Command History" },
              { "<leader>sC",      function() Snacks.picker.commands() end,                                    desc = "Commands" },
              { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                 desc = "Diagnostics" },
              { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                          desc = "Buffer Diagnostics" },
              { "<leader>sh",      function() Snacks.picker.help() end,                                        desc = "Help Pages" },
              { "<leader>sH",      function() Snacks.picker.highlights() end,                                  desc = "Highlights" },
              { "<leader>si",      function() Snacks.picker.icons() end,                                       desc = "Icons" },
              { "<leader>sj",      function() Snacks.picker.jumps() end,                                       desc = "Jumps" },
              { "<leader>sk",      function() Snacks.picker.keymaps() end,                                     desc = "Keymaps" },
              { "<leader>sl",      function() Snacks.picker.loclist() end,                                     desc = "Location List" },
              { "<leader>sm",      function() Snacks.picker.marks() end,                                       desc = "Marks" },
              { "<leader>sM",      function() Snacks.picker.man() end,                                         desc = "Man Pages" },
              { "<leader>sp",      function() Snacks.picker.lazy() end,                                        desc = "Search for Plugin Spec" },
              { "<leader>sq",      function() Snacks.picker.qflist() end,                                      desc = "Quickfix List" },
              { "<leader>sR",      function() Snacks.picker.resume() end,                                      desc = "Resume" },
              { "<leader>su",      function() Snacks.picker.undo() end,                                        desc = "Undo History" },
              { "<leader>uC",      function() Snacks.picker.colorschemes({ layout = { preset = "ivy" } }) end, desc = "Colorschemes" },
              -- LSP
              { "gd",              function() Snacks.picker.lsp_definitions() end,                             desc = "Goto Definition" },
              { "gD",              function() Snacks.picker.lsp_declarations() end,                            desc = "Goto Declaration" },
              { "gR",              function() Snacks.picker.lsp_references() end,                              nowait = true,                     desc = "References" },
              { "gI",              function() Snacks.picker.lsp_implementations() end,                         desc = "Goto Implementation" },
              { "gy",              function() Snacks.picker.lsp_type_definitions() end,                        desc = "Goto T[y]pe Definition" },
              { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                 desc = "LSP Symbols" },
              { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                       desc = "LSP Workspace Symbols" },
              -- Other
              -- { "<leader>z",       function() Snacks.zen() end,                                                desc = "Toggle Zen Mode" },
              -- { "<leader>Z",       function() Snacks.zen.zoom() end,                                           desc = "Toggle Zoom" },
              { "<leader>.",       function() Snacks.scratch() end,                                            desc = "Toggle Scratch Buffer" },
              { "<leader>S",       function() Snacks.scratch.select() end,                                     desc = "Select Scratch Buffer" },
              { "<leader>n",       function() Snacks.notifier.show_history() end,                              desc = "Notification History" },
              { "<leader>bd",      function() Snacks.bufdelete() end,                                          desc = "Delete Buffer" },
              { "<leader>cR",      function() Snacks.rename.rename_file() end,                                 desc = "Rename File" },
              { "<leader>gB",      function() Snacks.gitbrowse() end,                                          desc = "Git Browse",               mode = { "n", "v" } },
              { "<leader>gg",      function() Snacks.lazygit() end,                                            desc = "Lazygit" },
              { "<leader>un",      function() Snacks.notifier.hide() end,                                      desc = "Dismiss All Notifications" },
              { "<c-/>",           function() Snacks.terminal() end,                                           desc = "Toggle Terminal" },
              { "<c-_>",           function() Snacks.terminal() end,                                           desc = "which_key_ignore" },
              -- { "]]",              function() Snacks.words.jump(vim.v.count1) end,                             desc = "Next Reference",           mode = { "n", "t" } },
              -- { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                            desc = "Prev Reference",           mode = { "n", "t" } },
              {
                  "<leader>N",
                  desc = "Neovim News",
                  function()
                      Snacks.win({
                          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                          width = 0.6,
                          height = 0.6,
                          wo = {
                              spell = false,
                              wrap = false,
                              signcolumn = "yes",
                              statuscolumn = " ",
                              conceallevel = 3,
                          },
                      })
                  end,
              },
      -- stylua: ignore end
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>ut")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = { "Trouble" },
    opts = { use_diagnostic_signs = true },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- filetype icons
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=true win.size.width=0.15<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=true win.position=right win.size.width=0.3<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
}
