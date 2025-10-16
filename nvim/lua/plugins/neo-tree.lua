-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute { source = 'filesystem', focus = true }
      end,
      desc = 'NeoTree Toggle',
    },

    {
      '<C-n>',
      function()
        require('neo-tree.command').execute { source = 'last', toggle = true }
      end,
      desc = 'NeoTree Toggle',
    },
    {
      '<leader>ge',
      ':Neotree git_status<CR>',
      desc = 'Git Explorer',
    },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute { source = 'buffers', toggle = true }
      end,
      desc = 'Buffer Explorer',
    },
    {
      '<leader>de',
      function()
        require('neo-tree.command').execute { source = 'document_symbols', toggle = true }
      end,
      desc = 'Buffer Explorer',
    },
  },
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  init = function()
    -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
    -- because `cwd` is not set up properly.
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
      desc = 'Start Neo-tree with directory',
      once = true,
      callback = function()
        if package.loaded['neo-tree'] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == 'directory' then
            require 'neo-tree'
          end
        end
      end,
    })
  end,
  opts = {
    renderer = {
      --note on icons:
      --in some terminals, some patched fonts cut off glyphs if not given extra space
      --either add extra space, disable icons, or change font
      icons = {
        show = {
          file = false,
          folder = false,
          folder_arrow = true,
          git = true,
        },
      },
    },
    view = {
      width = 25,
      side = 'right',
    },
    sync_root_with_cwd = true, --fix to open cwd with tree
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      update_root = true,
    },
    source_selector = {
      winbar = true,
    },
    sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      position = 'right',
      mappings = {
        ['<leader>e'] = 'close_window',
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
          desc = 'Copy Path to Clipboard',
        },
        ['P'] = { 'toggle_preview', config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
        },
      },
    },
  },
  lazy = false,
}
