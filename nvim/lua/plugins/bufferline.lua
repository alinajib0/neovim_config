return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Close Others' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    { '<A-1>', '<cmd>BufferLineGoToBuffer 1<cr>', desc = 'Move to buffer 1' },
    { '<A-2>', '<cmd>BufferLineGoToBuffer 2<cr>', desc = 'Move to buffer 2' },
    { '<A-3>', '<cmd>BufferLineGoToBuffer 3<cr>', desc = 'Move to buffer 3' },
    { '<A-4>', '<cmd>BufferLineGoToBuffer 4<cr>', desc = 'Move to buffer 4' },
    { '<A-5>', '<cmd>BufferLineGoToBuffer 5<cr>', desc = 'Move to buffer 5' },
    { '<A-6>', '<cmd>BufferLineGoToBuffer 6<cr>', desc = 'Move to buffer 6' },
    { '<A-7>', '<cmd>BufferLineGoToBuffer 7<cr>', desc = 'Move to buffer 7' },
    { '<A-8>', '<cmd>BufferLineGoToBuffer 8<cr>', desc = 'Move to buffer 8' },
    { '<A-9>', '<cmd>BufferLineGoToBuffer 9<cr>', desc = 'Move to buffer 9' },
    { '<A-0>', '<cmd>BufferLineGoToBuffer -1<cr>', desc = 'Move to last buffer' },
  },
  opts = {
    options = {
      -- mode = 'tabs',

      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
