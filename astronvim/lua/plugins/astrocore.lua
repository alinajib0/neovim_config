-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- easily configure auto commands
    autocmds = {
      myGroup = {
        {
          event = { "FileType" },
          desc = "spellcheck in md",
          pattern = "markdown",
          command = "setlocal spell wrap",
        },
        {
          event = { "FileType" },
          desc = "disable automatic comment on newline",
          pattern = "*",
          callback = function() vim.opt_local.formatoptions:remove { "c", "r", "o" } end,
        },
        {
          event = { "BufReadPost" },
          desc = "restore cursor pos on file open",
          pattern = "*",
          callback = function()
            local line = vim.fn.line "'\""
            if line > 1 and line <= vim.fn.line "$" then vim.cmd "normal! g'\"" end
          end,
        },
        {
          event = { "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" },
          pattern = "*",
          callback = function()
            if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then vim.opt.relativenumber = true end
          end,
        },
      },
    },
    -- easily configure user commands
    commands = {
      -- key is the command name
      -- AstroReload = {
      --   -- first element with no key is the command (string or function)
      --   function() require("astrocore").reload() end,
      --   -- the rest are options for creating user commands (:h nvim_create_user_command)
      --   desc = "Reload AstroNvim (Experimental)",
      -- },
    },
    -- Configure diagnostics options (`:h vim.diagnostic.config()`)
    diagnostics = {
      update_in_insert = false,
    },
    -- passed to `vim.filetype.add`
    -- filetypes = {
    --   -- see `:h vim.filetype.add` for usage
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     [".foorc"] = "fooscript",
    --   },
    --   pattern = {
    --     [".*/etc/foo/.*"] = "fooscript",
    --   },
    -- },
    -- Configuration of vim mappings to create
    mappings = {
      -- map mode (:h map-modes)
      n = {
        -- use vimscript strings for mappings
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-vim.v.count1) end,
          desc = "Previous buffer",
        },
        ["<A-k>"] = { "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move Up" },
        ["<A-j>"] = { "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move Down" },

        x = { '"_x' },
        ["<Leader>p"] = { '"0p' },
        ["<Leader>P"] = { '"0P' },
        ["<Leader>c"] = { '"_c' },
        ["<Leader>C"] = { '"_C' },
        ["<Leader>d"] = { '"_d' },
        ["<Leader>D"] = { '"_D' },
        ["+"] = { "<C-a>" },
        ["-"] = { "<C-x>" },
        ["J"] = { "mzJ`z" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },
        ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Down" },
        ["<Down>"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Down" },
        ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Up" },
        ["<Up>"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Up" },
        ["<C-a>"] = { "ggVG", desc = "select all" },
        ["<leader>tN"] = { "<cmd>tabnew<cr>", desc = "New Tab" },
        ["<C-j>"] = { "<cmd>tabnext<cr>", desc = "Next Tab" },
        ["<leader><tab>"] = { "<cmd>tabprevious<cr>", desc = "Previous Tab" },
        ["<leader>td"] = { "<cmd>tabclose<cr>", desc = "Close Tab" },
        ["<leader>tc"] = { ":Copilot disable<cr>", silent = true, noremap = true, desc = "Disable Copilot" },
        ["<leader>tC"] = { ":Copilot enable<cr>", silent = true, noremap = true, desc = "Enable Copilot" },
        ["<leader>ts"] = {
          function()
            if vim.wo.spell then
              vim.wo.spell = false
            else
              vim.wo.spell = true
            end
          end,
          desc = "toggle spell",
        },
        ["<leader>j"] = { vim.diagnostic.open_float, desc = "Line Diagnostics" },
        ["<leader>k"] = { "z=", desc = "Check spell" },
      },
      i = {
        ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", desc = "Move Down" },
        ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", desc = "Move Up" },
      },

      v = {
        ["<A-j>"] = { ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", desc = "Move Down" },
        ["<A-k>"] = { ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", desc = "Move Up" },
        ["<Leader>p"] = { '"0p' },
        ["<Leader>c"] = { '"_c' },
        ["<Leader>C"] = { '"_C' },
        ["<Leader>d"] = { '"_d' },
        ["<Leader>D"] = { '"_D' },
        ["<"] = { "<gv" },
        [">"] = { ">gv" },
        ["="] = { "=gv" },
      },
      x = {
        ["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Down" },
        ["<Down>"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Down" },
        ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Up" },
        ["<Up>"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Up" },
      },
      t = {
        ["<leader><Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
      },
    },
    -- easily configure functions on key press
    on_keys = {
      -- first key is the namespace
      -- auto_hlsearch = {
      --   -- list of functions to execute on key press (:h vim.on_key)
      --   function(char) -- example automatically disables `hlsearch` when not actively searching
      --     if vim.fn.mode() == "n" then
      --       local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
      --       if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
      --     end
      --   end,
      -- },
    },
    -- easily configure vim options
    options = {
      -- first key is the type of option `vim.<first_key>`
      opt = {
        scrolloff = 5,
      },
      -- g = {
      --   -- set global `vim.g` settings here
      -- },
    },
    -- configure AstroNvim features
    features = {
      -- autopairs = true, -- enable or disable autopairs on start
      -- cmp = true, -- enable or disable cmp on start
      -- highlighturl = true, -- enable or disable highlighting of urls on start
      -- -- table for defining the size of the max file for all features, above these limits we disable features like treesitter.
      -- large_buf = {
      --   -- whether to enable large file detection for a buffer (must return false to disable)
      --   -- first parameter is the buffer number, the second is the large buffer configuration table
      --   -- return values:
      --   --   - `true` or `nil` to continue and respects all changes made to the large buffer configuration table
      --   --   - `false` to disable large file detection for the buffer
      --   --   - a new table of large buffer options to use instead of the defaults
      --   enabled = function(bufnr, config) end,
      --   notify = true, -- whether or not to display a notification when a large file is detected
      --   size = 1024 * 100, -- max file size (or false to disable check)
      --   lines = 10000, -- max number of lines (or false to disable check)
      --   line_length = 1000, -- average line length (or false to disable check)
      -- },
      -- notifications = true, -- enable or disable notifications on start
    },
    -- Enable git integration for detached worktrees
    git_worktrees = {
      -- { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/.dot" },
    },
    -- Configure project root detection, check status with `:AstroRootInfo`
    rooter = {
      -- list of detectors in order of prevalence, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = {
        "lsp", -- highest priority is getting workspace from running language servers
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
        { "lua", "MakeFile", "package.json" }, -- lastly check for known project root files
      },
      -- ignore things from root detection
      ignore = {
        servers = {}, -- list of language server names to ignore (Ex. { "efm" })
        dirs = {}, -- list of directory patterns (Ex. { "~/.cargo/*" })
      },
      -- automatically update working directory (update manually with `:AstroRoot`)
      autochdir = false,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "global",
      -- show notification on every working directory change
      notify = false,
    },
    -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
  },
}
