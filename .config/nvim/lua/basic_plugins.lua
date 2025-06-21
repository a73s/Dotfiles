return{
  {
    'mbbill/undotree',
    lazy = true,
    event = 'VimEnter',
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR><C-w><C-h>', { desc = 'Toggle [U]ndo Tree' })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { tab_char = '┋', char = '▎' }
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },


    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon Menu" })
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [A]dd" })
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon Select [1]" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon Select [2]" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon Select [3]" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon Select [4]" })
    end,
  },

  {
    "dstein64/nvim-scrollview",
    opts = {
      -- excluded_filetypes = {'nerdtree'},
      -- current_only = true,
      base = 'right',
      signs_on_startup = {'diagnostics', 'marks', 'search', 'conflicts'},
      scrollview_line_limit = 20000,
      diagnostics_severities = {vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN}
    },
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function ()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterRed',
          'RainbowDelimiterBlue',
          -- 'RainbowDelimiterViolet',
          -- 'RainbowDelimiterOrange',
          -- 'RainbowDelimiterGreen',
          -- 'RainbowDelimiterCyan',
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      min_window_height = 20,
      separator = '⸺',
      max_linex = 7,
    },
  },
}
