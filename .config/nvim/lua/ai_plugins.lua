return{
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionActions<CR>', desc = '[A]I, [A]ctions', mode = {'v', 'n'}},
      { '<leader>ac', '<cmd>CodeCompanionChat<CR>', desc = '[A]I, [C]hat' },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "o4mini",
        },
        cmd = {
          adapter = "gemini_fast",
        },
      },

      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = io.popen("secret-tool lookup xdg:schema GEMINI_API_KEY"):read(),
              model = "gemini-2.5-pro-exp-03-25",
            },
          })
        end,
        gemini_fast = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = io.popen("secret-tool lookup xdg:schema GEMINI_API_KEY"):read(),
              model = "gemini-2.0-flash",
            },
          })
        end,
        o4mini = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = io.popen("secret-tool lookup xdg:schema OPENAI_API_KEY"):read(),
              model = "o4-mini",
            },
          })
        end,
      },

      prompt_library = {
        ["Document Function"] = {
          strategy = "inline",
          description = "Document A Function",
          opts = {
            index = 1,
            is_slash_cmd = false,
            auto_submit = false,
            short_name = "docs",
          },
          prompts = {
            {
              role = "user",
              content = "I'm writing the documentation a function in my code. Can you help me write it? Here is the function I would like you to write documentation for. Please do not change the function. Please insert documentation before the function.",
            },
          },
        },

        ["Improve"] = {
          strategy = "chat",
          description = "Improve Code",
          opts = {
            short_name = "expert",
            auto_submit = false,
            stop_context_insertion = true,
            -- user_prompt = true,
          },

          prompts = {
            {
              role = "system",
              content = function(context)
                return "I want you to act as a senior "
                  .. context.filetype
                  .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\nHow can this be improved?"
              end,
              opts = {
                contains_code = true,
              }
            },
          },
        },
      },
    },
  },
}
