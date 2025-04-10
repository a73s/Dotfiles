return{
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },

    lazy = true,

    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debugger Continue"},
      { "<F6>", function() require("dapui").toggle() end, desc = "Toggle Dapui" },
      { "<F7>", function() require("dap").toggle_breakpoint() end, desc = "Debugger Breakpoint"},
      { "<F8>", function() require("dap").terminate() end, desc = "Debugger "},

      { "<F10>", function() require("dap").step_over() end, desc = "Debugger Step Over"},
      { "<F11>", function() require("dap").step_into() end, desc = "Debugger Step Into"},
      { "<F12>", function() require("dap").step_out() end, desc = "Debugger Step Out"},
    },

    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      ui.setup(
        {
          controls = {
            element = "repl",
            enabled = true,
            icons = {
              disconnect = "",
              pause = "",
              play = "",
              run_last = "",
              step_back = "",
              step_into = "",
              step_out = "",
              step_over = "",
              terminate = ""
            }
          },
          element_mappings = {},
          expand_lines = true,
          floating = {
            border = "single",
            mappings = {
              close = { "q", "<Esc>" }
            }
          },
          force_buffers = true,
          icons = {
            collapsed = "",
            current_frame = "",
            expanded = ""
          },
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.5
                },
                {
                  id = "stacks",
                  size = 0.2
                },
                {
                  id = "watches",
                  size = 0.15
                },
                {
                  id = "breakpoints",
                  size = 0.15
                },
              },
              position = "left",
              size = 50
            },
            {
              elements = {
                {
                  id = "repl",
                  size = 0.5
                },
                {
                  id = "console",
                  size = 0.5
                }
              },
              position = "bottom",
              size = 20
            }
          },
          mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
          },
          render = {
            indent = 1,
            max_value_lines = 100
          },
        }
      )


      dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/alacritty',
        args = {'-e'},
      }
      dap.defaults.fallback.force_external_terminal = true

      -- See
      -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Interpreters.html
      -- https://sourceware.org/gdb/current/onlinedocs/gdb.html/Debugger-Adapter-Protocol.html
      dap.adapters.gdb = {
        name = "gdb",
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--quiet" },
      }

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "/home/adam/repos/cpptools-linux-x64/extension/debugAdapters/bin/OpenDebugAD7",
      }

      require("dap.ext.vscode").load_launchjs("./launch.json", {cppdbg = {'c','cpp'}, gdb = {'c','cpp'}})

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
