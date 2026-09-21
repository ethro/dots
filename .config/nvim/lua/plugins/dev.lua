-- colorful-menu -----------------------
-- local colorful_menu = require("colorful-menu")
-- colorful_menu.setup({})

-- blink -------------------------------
vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build blink.cmp after install/update",
  group = vim.api.nvim_create_augroup("blink_build", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and (kind == "install" or kind == "update") then
      vim.notify("Building blink.cmp...", vim.log.levels.INFO)
      vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
      local cmp = require("blink.cmp")
      cmp.build():pwait()
    end
  end,
})

local blink = require("blink.cmp")
blink.setup({
  keymap = {
    preset = "default",
  },
  completion = {
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
        -- components = {
        --   label = {
        --     text = function(ctx)
        --       return require("colorful-menu").blink_components_text(ctx)
        --     end,
        --     highlight = function(ctx)
        --       return require("colorful-menu").blink_components_highlight(ctx)
        --     end,
        --   },
        -- },
      },
    },
    documentation = { auto_show = true },
    list = {
      selection = {
        auto_insert = true,
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
  signature = { enabled = true },
  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a Lua implementation instead by using `implementation = "lua"`
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "lua" },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      "ripgrep",
    },
    per_filetype = {
      sql = { "lsp", "snippets", "buffer" },
    },
    providers = {
      lsp = {
        score_offset = 100,
      },
      buffer = {
        score_offset = 90,
      },
      path = {
        score_offset = 80,
      },
      snippets = {
        score_offset = 70,
        opts = {
          search_paths = { vim.fn.stdpath("config") .. "/snippets" },
        },
      },
      ripgrep = {
        score_offset = 60,
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {
          prefix_min_len = 3,
          backend = {
            use = "gitgrep-or-ripgrep",
            -- use = "ripgrep",
            ripgrep = {
              ignore_paths = { os.getenv("HOME") },
            },
          },
        },
        enabled = false,
        -- enabled = function()
        --   local _cwd = string.lower(vim.fn.getcwd())
        --   local _home = string.lower(os.getenv("HOME"))
        --
        --   return _cwd ~= _home
        -- end,
      },
    },
  },
})

-- diffview ----------------------------
local diffview = require("diffview")
diffview.setup({
  hooks = {
    view_enter = function(view)
      vim.cmd("colorscheme kanagawa")
    end,
    view_leave = function(view)
      vim.cmd("colorscheme kanagawa")
    end,
  },
})
vim.keymap.set("n", "<leader>Do", ":DiffviewOpen<CR>", { desc = "Diffview Open" })
vim.keymap.set("n", "<leader>Df", ":DiffviewToggleFiles<CR>", { desc = "Diffview Toggle Files" })
vim.keymap.set("n", "<leader>Dc", ":DiffviewClose<CR>", { desc = "Diffview Close" })
vim.keymap.set("n", "<leader>Dr", ":DiffviewRefresh<CR>", { desc = "Diffview Refresh" })
vim.keymap.set("n", "<leader>Dh", ":DiffviewFileHistory %<CR>", { desc = "Diffview File History" })
vim.keymap.set("n", "<leader>DH", ":DiffviewFileHistory<CR>", { desc = "Diffview File History" })

-- gitsigns ----------------------------
local gitsigns = require("gitsigns")
gitsigns.setup({
  current_line_blame = true,
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function kmap(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    end
    kmap("n", "]g", gs.next_hunk, "Next Hunk")
    kmap("n", "[g", gs.prev_hunk, "Prev Hunk")
    kmap({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    kmap({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    kmap("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
    kmap("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
    kmap("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
    kmap("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    kmap("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, "Blame Line")
    kmap("n", "<leader>gB", function()
      gs.blame({ full = true })
    end, "Blame")
    kmap("n", "<leader>gd", gs.diffthis, "Diff This")
    kmap("n", "<leader>gD", function()
      gs.diffthis("~")
    end, "Diff This ~")
    kmap({ "o", "x" }, "<leader>Gh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    kmap("n", "<leader>gq", function()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)
        if bufname:find("^gitsigns://") then
          vim.api.nvim_win_close(win, true)
          return
        end
      end
    end, "Close gitsigns diff")
  end,
})

-- goto-preview ------------------------
local goto_preview = require("goto-preview")
goto_preview.setup({
  default_mappings = true,
  resizing_mappings = true,
})

-- todo-comments -----------------------
require("todo-comments").setup({})

-- overseer ----------------------------
require("overseer").setup()
vim.keymap.set("n", "<leader>Oo", "<cmd>OverseerRun<CR>", { desc = "OverseerRun" })
vim.keymap.set("n", "<leader>Ot", "<cmd>OverseerToggle<CR>", { desc = "OverseerToggle" })

-- treesitter --------------------------
local languages = {
  "asm",
  "bash",
  "bitbake",
  "c",
  "c_sharp",
  "cmake",
  "comment",
  "cpp",
  "css",
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
  "go",
  "gomod",
  "gosum",
  "gowork",
  "gpg",
  "graphql",
  "html",
  "http",
  "idl",
  "ini",
  "javascript",
  "jq",
  "jsdoc",
  "json",
  "json5",
  "kconfig",
  "linkerscript",
  "llvm",
  "lua",
  "luadoc",
  "luap",
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
  "query",
  "regex",
  "requirements",
  "rust",
  "ssh_config",
  "tcl",
  "todotxt",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "udev",
  "vhdl",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "yang",
}

local installed = require("nvim-treesitter.config").get_installed()
local treesitter = require("nvim-treesitter")

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

treesitter.install(vim
  .iter(languages)
  :filter(function(language)
    return not vim.tbl_contains(installed, language)
  end)
  :totable())

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update Tree-sitter parsers after plugin updates",
  group = vim.api.nvim_create_augroup("nvim_treesitter_update", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

-- mason -------------------------------
require("mason").setup({
  ui = {
    check_outdated_packages_on_open = false,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({
  ensure_installed = {
    -- dap
    "bash-debug-adapter",
    "codelldb",
    "cpptools",
    "debugpy",

    -- dev
    "basedpyright",
    "clang-format",
    "clangd",
    "cmakelang",
    "docker-language-server",
    "flake8",
    "gopls",
    "lua_ls",
    "marksman",
    "mpls",
    "mypy",
    "pydocstyle",
    "rstcheck",
    "ruff",
    "selene",
    "shfmt",
    "shuck",
    "sqls",
    "stylua",
    "tclint",
    "vsg",
    "vulture",
    "yamlfmt",
    "yamllint",
    -- "jsonls",
    -- "shellcheck",
    -- "shellharden",
    -- "ts_ls",
    -- "yamlls",
  },
  auto_update = false,
  run_on_start = true,
})

require("workspace-diagnostics").setup()

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

vim.api.nvim_create_autocmd(
  "LspAttach",
  { --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then
        if client:supports_method("workspace/diagnostic", ev.buf) then
          vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
        else
          require("workspace-diagnostics").populate_workspace_diagnostics(client, ev.buf)
        end
      end

      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

      local opts = function(desc)
        return { buffer = ev.buf, silent = true, desc = desc }
      end
      -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts("Go to definition"))
      -- vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts("Hover documentation"))
      -- vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts("Go to implementation"))
      -- vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition, opts("Go to type definition"))
      -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("Find references"))
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename symbol"))

      -- Use tiny-code-action to get a preview
      -- If this doesn't prove worthwhile, just change back to `vim.lsp.buf.code_action`
      vim.keymap.set({ "n", "v" }, "<leader>ca", function()
        require("tiny-code-action").code_action({
          filter = function(action)
            return not action.disabled
          end,
        })
      end, opts("Code action"))
      -- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts("Format buffer"))

      -- vim.keymap.set("n", "<leader>d", function()
      -- 	vim.diagnostic.open_float({
      -- 		border = "rounded",
      -- 	})
      -- end, opts("Show diagnostics float"))
      local client = vim.lsp.get_client_by_id(ev.data.client_id)

      if client then
        -- inlayHint
        if client:supports_method("textDocument/inlayHint") then
          vim.keymap.set("n", "<leader>uh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
          end, { desc = "LSP: Toggle Inlay Hints" })
        end

        if client:supports_method("textDocument/documentHighlight") then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = ev.buf,
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
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
      end
    end,
  }
)
vim.keymap.set("n", "<leader>Om", ":Mason<CR>", { desc = "Mason" })

-- conform -----------------------------
local conform = require("conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    cmake = { "cmake-format" },
    cpp = { "clang-format" },
    json = { "clang-format" },
    lua = { "stylua" },
    python = { "ruff" },
    sh = { "shfmt" },
    tcl = { "tclfmt" },
    vhdl = { "vsg" },
    yaml = { "yamlfmt" },
  },
  formatters = {
    clang_format = {
      -- Use --style=file to look for .clang-format in the project
      -- Use fallback-style to specify what happens if no file is found
      prepend_args = { "--fallback-style=Microsoft" },
    },
    cmake_format = {
      command = "cmake-format", -- Ensure this matches the binary installed by cmakelang
      prepend_args = { "--option", "IndentWidth=4" },
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

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  local _conform = require("conform")
  _conform.format()
end, { desc = "Format" })

vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    -- FormatToggle! will toggle formatting just for this buffer
    if vim.b.autoformat then
      vim.b.autoformat = false
    else
      vim.b.autoformat = true
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

-- nvim-lint ---------------------------
local nvim_lint = require("lint")
nvim_lint.linters_by_ft = {
  -- Event to trigger linters
  python = { "mypy", "flake8", "pydocstyle", "vulture" },
  cmake = { "cmake-lint" },
  -- lua = { "selene" },
  rst = { "rstcheck" },
  sh = { "shellcheck", "shellharden" },
  tcl = { "tclint" },
  yaml = { "yamllint" },
  vhdl = { "vsg" },
  -- Use the "*" filetype to run linters on all filetypes.
  -- ['*'] = { 'global linter' },
  -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
  -- ['_'] = { 'fallback linter' },
}
-- nvim_lint.linters = {
--   -- -- Example of using selene only when a selene.toml file is present
--   -- selene = {
--   --   -- `condition` is another LazyVim extension that allows you to
--   --   -- dynamically enable/disable linters based on the context.
--   --   condition = function(ctx)
--   --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
--   --   end,
--   -- },
-- }

local _M_lint = {}
function _M_lint.debounce(ms, fn)
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
function _M_lint.lint()
  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = nvim_lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Add fallback linters.
  if #names == 0 then
    vim.list_extend(names, nvim_lint.linters_by_ft["_"] or {})
  end

  -- Add global linters.
  vim.list_extend(names, nvim_lint.linters_by_ft["*"] or {})

  -- Filter out linters that don't exist or don't match the condition.
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
  names = vim.tbl_filter(function(name)
    local linter = nvim_lint.linters[name]
    -- if not linter then
    --   Util.warn("Linter not found: " .. name, { title = "nvim-lint" })
    -- end
    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
  end, names)

  -- Run linters.
  if #names > 0 then
    nvim_lint.try_lint(names)
  end
end

_M_lint.events = { "BufWritePost", "BufReadPost", "InsertLeave" }
vim.api.nvim_create_autocmd(_M_lint.events, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = _M_lint.debounce(200, _M_lint.lint),
})

-- snacks ------------------------------
local snacks = require("snacks")
snacks.setup({
  animate = { enabled = false },
  bigfile = { enabled = true },
  bufdelete = { enabled = false },
  dashboard = {
    enabled = false,
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
    files = {
      ignored = true,
      hidden = true,
    },
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
})
-- stylua: ignore start
-- Top Pickers & Explorer
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end,                                       { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,",       function() Snacks.picker.buffers() end,                                     { desc = "Buffers" })
vim.keymap.set("n", "<leader>/",       function() Snacks.picker.grep() end,                                        { desc = "Grep" })
vim.keymap.set("n", "<leader>:",       function() Snacks.picker.command_history() end,                             { desc = "Command History" })
vim.keymap.set("n", "<leader>n",       function() Snacks.picker.notifications() end,                               { desc = "Notification History" })
-- { "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" },
-- find
vim.keymap.set("n", "<leader>fb",      function() Snacks.picker.buffers() end,                                     { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,     { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff",      function() Snacks.picker.files() end,                                       { desc = "Find Files" })
vim.keymap.set("n", "<leader>fF",      function()
  -- Get a list of all direcotries in the workspace
  local workspace_path = vim.fn.getcwd()
  local directories = vim.fn.systemlist("find " .. workspace_path .. " -type d")

  -- Preset the directories to the user for selection
  vim.ui.select(directories, {
    prompt = "Select a directory:",
    format_item = function (item)
      return item
    end
  }, function (choice)
    if choice then
        Snacks.picker.files({ dirs = {choice }, hidden = true, ignored = true })
      else
        print("No directory selected")
      end
  end) end, { desc = "Find Files in directory" })
vim.keymap.set("n", "<leader>fg",      function() Snacks.picker.git_files() end,                                   { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp",      function() Snacks.picker.projects() end,                                    { desc = "Projects" })
vim.keymap.set("n", "<leader>fr",      function() Snacks.picker.recent() end,                                      { desc = "Recent" })
-- git
vim.keymap.set("n", "<leader>gl",      function() Snacks.picker.git_log() end,                                     { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL",      function() Snacks.picker.git_log_line() end,                                { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gi",      function() Snacks.picker.git_status() end,                                  { desc = "Git Status" })
vim.keymap.set("n", "<leader>ge",      function() Snacks.picker.git_diff() end,                                    { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf",      function() Snacks.picker.git_log_file() end,                                { desc = "Git Log File" })
-- Grep
vim.keymap.set("n", "<leader>sb",      function() Snacks.picker.lines() end,                                       { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg",      function() Snacks.picker.grep({hidden = true, ignored=true}) end,           { desc = "Grep" })
vim.keymap.set("n", "<leader>sG",      function()
  -- Get a list of all direcotries in the workspace
  local workspace_path = vim.fn.getcwd()
  local directories = vim.fn.systemlist("find " .. workspace_path .. " -type d")

  -- Preset the directories to the user for selection
  vim.ui.select(directories, {
    prompt = "Select a directory:",
    format_item = function (item)
      return item
    end
  }, function (choice)
    if choice then
        Snacks.picker.grep({ dirs = {choice }, hidden = true, ignored = true })
      else
        print("No directory selected")
      end
  end) end, { desc = "Grep in directory" })
vim.keymap.set("n", "<leader>sW",      function()
  -- Get a list of all direcotries in the workspace
  local workspace_path = vim.fn.getcwd()
  local directories = vim.fn.systemlist("find " .. workspace_path .. " -type d")

  -- Preset the directories to the user for selection
  vim.ui.select(directories, {
    prompt = "Select a directory:",
    format_item = function (item)
      return item
    end
  }, function (choice)
    if choice then
        Snacks.picker.grep_word({ dirs = {choice }, hidden = true, ignored = true })
      else
        print("No directory selected")
      end
  end) end, { desc = "Grep word in directory" })

vim.keymap.set({"n","x"}, "<leader>sw",      function() Snacks.picker.grep_word() end,                                 { desc = "Visual selection or word"})
-- search
vim.keymap.set("n", '<leader>s"',      function() Snacks.picker.registers() end,                                   { desc = "Registers" })
vim.keymap.set("n", '<leader>s/',      function() Snacks.picker.search_history() end,                              { desc = "Search History" })
vim.keymap.set("n", "<leader>sa",      function() Snacks.picker.autocmds() end,                                    { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sb",      function() Snacks.picker.lines() end,                                       { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sc",      function() Snacks.picker.command_history() end,                             { desc = "Command History" })
vim.keymap.set("n", "<leader>sC",      function() Snacks.picker.commands() end,                                    { desc = "Commands" })
vim.keymap.set("n", "<leader>sd",      function() Snacks.picker.diagnostics() end,                                 { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                          { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh",      function() Snacks.picker.help() end,                                        { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH",      function() Snacks.picker.highlights() end,                                  { desc = "Highlights" })
vim.keymap.set("n", "<leader>si",      function() Snacks.picker.icons() end,                                       { desc = "Icons" })
vim.keymap.set("n", "<leader>sj",      function() Snacks.picker.jumps() end,                                       { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk",      function() Snacks.picker.keymaps() end,                                     { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl",      function() Snacks.picker.loclist() end,                                     { desc = "Location List" })
vim.keymap.set("n", "<leader>sm",      function() Snacks.picker.marks() end,                                       { desc = "Marks" })
vim.keymap.set("n", "<leader>sM",      function() Snacks.picker.man() end,                                         { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sp",      function() Snacks.picker.lazy() end,                                        { desc = "Search for Plugin Spec" })
vim.keymap.set("n", "<leader>sq",      function() Snacks.picker.qflist() end,                                      { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sR",      function() Snacks.picker.resume() end,                                      { desc = "Resume" })
vim.keymap.set("n", "<leader>su",      function() Snacks.picker.undo() end,                                        { desc = "Undo History" })
vim.keymap.set("n", "<leader>uC",      function() Snacks.picker.colorschemes({ layout = { preset = "ivy" } }) end, { desc = "Colorschemes" })
-- LSP
vim.keymap.set("n", "gd",              function() Snacks.picker.lsp_definitions() end,                             { desc = "Goto Definition" })
vim.keymap.set("n", "gD",              function() Snacks.picker.lsp_declarations() end,                            { desc = "Goto Declaration" })
vim.keymap.set("n", "gR",              function() Snacks.picker.lsp_references() end,                              { nowait = true, desc = "References" })
vim.keymap.set("n", "gI",              function() Snacks.picker.lsp_implementations() end,                         { desc = "Goto Implementation" })
vim.keymap.set("n", "gy",              function() Snacks.picker.lsp_type_definitions() end,                        { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                 { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                       { desc = "LSP Workspace Symbols" })
-- Other
-- { "<leader>z",       function() Snacks.zen() end,                                                { desc = "Toggle Zen Mode" },
-- { "<leader>Z",       function() Snacks.zen.zoom() end,                                           { desc = "Toggle Zoom" },
vim.keymap.set("n", "<leader>.",       function() Snacks.scratch() end,                                            { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S",       function() Snacks.scratch.select() end,                                     { desc = "Select Scratch Buffer" })
vim.keymap.set("n", "<leader>n",       function() Snacks.notifier.show_history() end,                              { desc = "Notification History" })
vim.keymap.set("n", "<leader>bd",      function() Snacks.bufdelete() end,                                          { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>cR",      function() Snacks.rename.rename_file() end,                                 { desc = "Rename File" })
-- vim.keymap.set({"n", "v"}, "<leader>gB",      function() Snacks.gitbrowse() end,                                       { desc = "Git Browse"})
vim.keymap.set("n", "<leader>gg",      function() Snacks.lazygit() end,                                            { desc = "Lazygit" })
vim.keymap.set("n", "<leader>un",      function() Snacks.notifier.hide() end,                                      { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<c-/>",           function() Snacks.terminal() end,                                           { desc = "Toggle Terminal" })
vim.keymap.set("n", "<c-_>",           function() Snacks.terminal() end,                                           { desc = "which_key_ignore" })
-- { "]]",              function() Snacks.words.jump(vim.v.count1) end,                             { desc = "Next Reference",           mode = { "n", "t" } },
-- { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                            { desc = "Prev Reference",           mode = { "n", "t" } },
-- stylua: ignore end
vim.keymap.set("n", "<leader>N", function()
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
end, { desc = "Neovim News" })

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

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.wo.diff then
      Snacks.toggle.diagnostics():set(false)
    end
  end,
})

-- trouble -----------------------------
local trouble = require("trouble")
trouble.setup({
  use_diagnostic_signs = true,
})

-- fidget ------------------------------
local fidget = require("fidget")
fidget.setup({})
