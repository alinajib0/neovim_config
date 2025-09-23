return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- find
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = '[F]ind [C]ommand History' })
      vim.keymap.set('n', '<leader>fM', builtin.man_pages, { desc = '[F]ind [M]an Pages' })
      vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[F]ind [M]arks' })
      vim.keymap.set('n', '<leader>fC', builtin.colorscheme, { desc = '[F]ind [C]olorscheme' })
      vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = '[F]ind [Q]ickfix' })
      vim.keymap.set('n', '<leader>fo', builtin.vim_options, { desc = '[F]ind vim [O]ption' })
      vim.keymap.set('n', '<leader>f"', builtin.registers, { desc = '[F]ind ["] registers' })
      vim.keymap.set('n', '<leader>fT', builtin.filetypes, { desc = '[F]ind File[T]ypes' })

      -- lsp
      vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = '[L]sp: [R]eferences' })
      vim.keymap.set('n', '<leader>lD', builtin.lsp_definitions, { desc = '[L]sp: [D]efinitions' })
      vim.keymap.set('n', '<leader>ls', builtin.lsp_workspace_symbols, { desc = '[L]sp: Workspace [S]ymbols' })
      vim.keymap.set('n', '<leader>lS', builtin.lsp_document_symbols, { desc = '[L]sp: Document_[S]ymbols' })
      vim.keymap.set('n', '<leader>lm', builtin.lsp_implementations, { desc = '[L]sp: i[M]plementations' })
      vim.keymap.set('n', '<leader>ld', builtin.diagnostics, { desc = '[L]sp: [D]iagnostics' })

      -- git
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[F]ind [C]ommits' })
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[F]ind [B]ranches' })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[F]ind [S]tatus' })
      vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = '[F]ind [S]tash' })

      -- treesitter
      vim.keymap.set('n', '<leader>j', builtin.treesitter, { desc = '[F]ind treesitter' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
