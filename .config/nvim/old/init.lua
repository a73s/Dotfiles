--vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed vim.g.have_nerd_font = true
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.wrap = false

-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 3000

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 10

-- vim.opt.confirm = true

-- [[ Basic Keymaps ]]
--	See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--	See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--	See `:help lua-guide-autocommands`

-- Toggle relative numbers on window chage
vim.api.nvim_create_augroup("custom-numbertoggle", {clear = true})

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "WinEnter"}, {
	desc = "Toggle on relative numbers",
	group = "custom-numbertoggle",
	callback = function()
		if vim.opt.number then
			vim.opt.relativenumber = true
		end
	end,
})
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "WinLeave"}, {
	desc = "Toggle off relative numbers",
	group = "custom-numbertoggle",
	callback = function()
		if vim.opt.number then
			vim.opt.relativenumber = false
		end
	end,
})

-- Highlight when yanking (copying) text
--	Try it with `yap` in normal mode
--	See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable extending single line comments when hitting enter
vim.api.nvim_create_autocmd('BufEnter', {

	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = vim.api.nvim_create_augroup('general-custom-autocmd', { clear = true }),
	desc = "Disable New Line Comment",
})

-- [[ Install `lazy.nvim` plugin manager ]]
--		See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--	event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--	config = function() ... end

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ 'tpope/vim-sleuth' },

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },

	{
		'lewis6991/gitsigns.nvim',

		event = 'VimEnter',

		keys = {
			{ '<leader>gd', '<cmd>Gitsigns diffthis<CR><C-w><C-h>', desc = "[G]it [D]iff" },
			{ '<leader>gn', '<cmd>Gitsigns nav_hunk next<CR>',		desc = "[G]it, [N]ext Hunk" },
			{ '<leader>gp', '<cmd>Gitsigns nav_hunk prev<CR>',		desc = "[G]it, [P]revious Hunk" },
			{ '<leader>gf', '<cmd>Gitsigns nav_hunk first<CR>',		desc = "[G]it, [F]irst Hunk" },
			{ '<leader>gl', '<cmd>Gitsigns nav_hunk last<CR>',		desc = "[G]it, [L]ast Hunk" },
			-- removed this bind since its kinda dangerous.
			-- replaced with reset_hunk so the changes will be more local to the cursor
			-- { '<leader>gr', '<cmd>Gitsigns reset_buffer<CR>', desc = "[G]it, [R]eset Buffer Changes"},
			{ '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>',			desc = "[G]it, [R]eset Hunk" },
			{ '<leader>gb', '<cmd>Gitsigns blame<CR>',				desc = "[G]it, [B]lame" },
		},

		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	{
	'folke/which-key.nvim',
	event = 'VimEnter',
	config = function()
		require('which-key').setup()

		-- Document existing key chains
		require('which-key').add {
			{
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>f", group = "[F]ile" },
				{ "<leader>f_", hidden = true },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>g_", hidden = true },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>w_", hidden = true },
			}

		}
	end,
	},

	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				build = 'make',

				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ 'nvim-tree/nvim-web-devicons',
				enabled = vim.g.have_nerd_font,
			},
		},
		config = function()
			-- Two important keymaps to use while in Telescope are:
			--	- Insert mode: <c-/>
			--	- Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			require('telescope').setup {

				defaults = {
					mappings = {
						-- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					},
				},
				pickers = {},

				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			local builtin = require 'telescope.builtin'
			vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
			vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
			vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
			vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
			vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
			vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
			vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
			-- vim.keymap.set('n', '<leader>e', builtin.diagnostics, { desc = 'Diagnostic [E]rrors in all buffers' })

			vim.keymap.set('n', '<leader>/', function()
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })

			vim.keymap.set('n', '<leader>s/', function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end, { desc = '[S]earch [/] in Open Files' })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set('n', '<leader>sn', function()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, { desc = '[S]earch [N]eovim files' })
		end,
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim

			{
				'williamboman/mason.nvim',
				opts = {
					PATH = 'append'
				}
			},

			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ 'folke/neodev.nvim', opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--	This is where a variable was first declared, or where a function is defined, etc.
					--	To jump back, press <C-t>.
					map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

					-- Find references for the word under your cursor.
					map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

					-- Jump to the implementation of the word under your cursor.
					--	Useful when your language has ways of declaring types without an actual implementation.
					map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

					-- Jump to the type of the word under your cursor.
					--	Useful when you're not sure what type a variable is and you want to see
					--	the definition of its *type*, not where it was *defined*.
					map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

					-- Fuzzy find all the symbols in your current document.
					--	Symbols are things like variables, functions, types, etc.
					map('<leader>fs', require('telescope.builtin').lsp_document_symbols, '[F]ile [S]ymbols (Doc Symbols)')

					-- Fuzzy find all the symbols in your current workspace.
					--	Similar to document symbols, except searches over your entire project.
					map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

					-- Rename the variable under your cursor.
					--	Most Language Servers support renaming across files, etc.
					map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

					-- Opens a popup that displays documentation about the word under your cursor
					--	See `:help K` for why this keymap.
					map('K', vim.lsp.buf.hover, 'Hover Documentation')

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--	For example, in C this would take you to the header.
					map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

					-- adds code completion

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--		See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						-- vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						--	buffer = event.buf,
						--	callback = vim.lsp.buf.document_highlight,
						-- })
						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--	By default, Neovim doesn't support everything that is in the LSP specification.
			--	When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--	So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"-header-insertion=never",
					},
				},
				cmake = {},
				pyright = {},

				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
						},
					},
				},
			}

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require('lspconfig')[server_name].setup(server)
					end,
				},
			}
		end,
	},

	--[[ { -- Autoformat
		'stevearc/conform.nvim',
		lazy = false,
		keys = {
			-- {
			--	"<leader>f",
			--	function()
			--		require("conform").format({ async = true, lsp_fallback = true })
			--	end,
			--	mode = "",
			--	desc = "[F]ormat buffer",
			-- },
		},
		opts = {
			notify_on_error = false,
			-- format_on_save = function(bufnr)
			--	-- Disable "format_on_save lsp_fallback" for languages that don't
			--	-- have a well standardized coding style. You can add additional
			--	-- languages here or re-enable it for the disabled ones.
			--	local disable_filetypes = { c = true, cpp = true }
			--	return {
			--		timeout_ms = 500,
			--		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			--	}
			-- end,
			formatters_by_ft = {
				-- lua = { 'stylua' },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	}, ]]

	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--		See the README about individual language/framework/plugin snippets:
					--		https://github.com/rafamadriz/friendly-snippets
					-- {
					--	 'rafamadriz/friendly-snippets',
					--	 config = function()
					--		 require('luasnip.loaders.from_vscode').lazy_load()
					--	 end,
					-- },
				},
			},
			'saadparwaiz1/cmp_luasnip',

			-- Adds other completion capabilities.
			--	nvim-cmp does not ship with all sources by default. They are split
			--	into multiple repos for maintenance purposes.
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			luasnip.config.setup {}

			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = 'menu,menuone,noinsert' },

				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-y>'] = cmp.mapping.confirm { select = true },
					['<C-e>'] = cmp.mapping.abort(),

					-- Manually trigger a completion from nvim-cmp.
					--	Generally you don't need this, because nvim-cmp will display
					--	completions whenever it has completion options available.
					['<C-Space>'] = cmp.mapping.complete {},

					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--		https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
				},
			}
		end,
	},

	{
		'Mofiqul/vscode.nvim',
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()

			local c = require('vscode.colors').get_colors()
			require('vscode').setup(
			{
				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				-- transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				-- disable_nvimtree_bg = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				--	vscLineNumber = '#FFFFFF',
				-- },

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
				}
			})

			vim.cmd.colorscheme 'vscode'
			-- You can configure highlights by doing something like:
			vim.cmd.hi 'Comment gui=none'

			local hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end

			local foreground = c.vscBack
			local grey = c.vscGray
			local yellow = c.vscDarkYellow
			local blue = c.vscMediumBlue
			local cyan = c.vscAccentBlue
			local red = c.vscRed
			local green = c.vscGreen

			hi('MiniStatuslineModeCommand', {fg = foreground, bg = yellow, bold = true})
			hi('MiniStatuslineModeInsert',	{fg = foreground, bg = blue, bold = true})
			hi('MiniStatuslineModeNormal',	{fg = grey, bg = foreground, bold = false})
			hi('MiniStatuslineModeOther',	{fg = foreground, bg = cyan, bold = true})
			hi('MiniStatuslineModeReplace', {fg = foreground, bg = red, bold = true})
			hi('MiniStatuslineModeVisual',	{fg = foreground, bg = green, bold = true})
		end,
	},

	{ -- Collection of various small independent plugins/modules
		'echasnovski/mini.nvim',
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--	- va)  - [V]isually select [A]round [)]paren
			--	- yinq - [Y]ank [I]nside [N]ext [']quote
			--	- ci'  - [C]hange [I]nside [']quote
			-- require('mini.ai').setup { n_lines = 500 }

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'	 - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require('mini.surround').setup()

			-- Simple and easy statusline.
			local statusline = require 'mini.statusline'
			statusline.setup({use_icons = vim.g.have_nerd_font})

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return '%p%%, %.l:%2L:%.c'
			end

			local map = require("mini.map")
			map.setup(
				{
					-- Highlight integrations (none by default)
					integrations = {
						map.gen_integration.builtin_search(),
						map.gen_integration.diff(),
						map.gen_integration.diff(),
						map.gen_integration.diagnostic(),
					},

					-- Symbols used to display data
					symbols = {
						-- Encode symbols. See `:h MiniMap.config` for specification and
						-- `:h MiniMap.gen_encode_symbols` for pre-built ones.
						-- Default: solid blocks with 3x2 resolution.
						encode = map.gen_encode_symbols.dot('4x2'),
						-- encode = map.gen_encode_symbols.block('3x2')

						-- Scrollbar parts for view and line. Use empty string to disable any.
						scroll_line = '█',
						scroll_view = '┃',
					},

					-- Window options
					window = {
						-- Whether window is focusable in normal way (with `wincmd` or mouse)
						focusable = false,

						-- Side to stick ('left' or 'right')
						side = 'right',

						-- Whether to show count of multiple integration highlights
						show_integration_count = true,

						-- Total width
						width = 20,

						-- Value of 'winblend' option
						winblend = 50,

						-- Z-index
						zindex = 10,
					},
				}
			)

			-- Mini map keybind
			vim.keymap.set('n', '<leader>m', require('mini.map').toggle, { desc= 'Toggle Mini.[M]ap' })
		end,
	},

	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		opts = {
			ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--	If you are experiencing weird indenting issues, add the language to
				--	the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { 'ruby' },
			},
			indent = { enable = true, disable = { 'ruby' } },
		},
		config = function(_, opts)
			---@diagnostic disable-next-line: missing-fields
			require('nvim-treesitter.configs').setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--		- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--		- Show your current context: https://githu
			--		.com/nvim-treesitter/nvim-treesitter-context
			--		- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},

	{
		'mbbill/undotree',
		event = 'VimEnter',
		opts = {},
		config = function()
			-- vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndo Tree' })
			-- this version allows me to automatically switch to the openned pane
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
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>",	"<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>",	"<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>",	"<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>",	"<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },


		config = function()
			local harpoon = require('harpoon')
			harpoon:setup()

			vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
				{ desc = "[H]arpoon Menu" })
			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon [A]dd" })
			vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon Select [1]" })
			vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon Select [2]" })
			vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon Select [3]" })
			vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon Select [4]" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "[H]arpoon [P]rev" })
			vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "[H]arpoon [N]ext" })
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
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},

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
					}
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
},

{
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})

-- vim: ts=4 sw=4
