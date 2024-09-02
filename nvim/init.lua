-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.hidden = true
vim.opt.wrap = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "/home/syk/.vim/undodir"
vim.opt.undofile = true
vim.o.showmode = false

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local colors = {
	dark_grey         = '#333333',
	medium_dark_grey  = '#555555',
	black             = '#000000',
	less_black        = '#232323',
	white             = '#FFFFFF',
	medium_grey       = '#777777',
	medium_light_grey = '#999999',
	medium_grey       = '#444444',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.white, bg = colors.medium_grey },
		b = { fg = colors.white, bg = colors.less_black },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.white, bg = colors.dark_grey } },
	visual = { a = { fg = colors.white, bg = colors.medium_dark_grey } },
	replace = { a = { fg = colors.white, bg = colors.dark_grey } },

	inactive = {
		a = { fg = colors.dark_grey, bg = colors.medium_light_grey },
		b = { fg = colors.white, bg = colors.less_black },
		c = { fg = colors.white },
	},
}

require("lazy").setup({
	spec = {
		{
			"kdheepak/monochrome.nvim",
			priority = 1000,
		},
		{

			"nvim-tree/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({})
			end,
		},
		{
			"phaazon/hop.nvim",
			lazy = true,
			config = function()
				require('hop').setup({
					keys = 'etovxqpdygfblzhckisuran',
					case_insensitive = true,
					multi_windows = true,
				})
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			config = function()
				require("ibl").setup({})
			end,
		},
		{
			'romgrk/barbar.nvim',
			dependencies = {
				'lewis6991/gitsigns.nvim', -- for git status
				'nvim-tree/nvim-web-devicons', -- for file icons
			},
			init = function() vim.g.barbar_auto_setup = false end,
			opts = {
				animation = true,
				insert_at_start = false,
				sidebar_filetypes = {
					NvimTree = true,
					undotree = {
						text = 'undotree',
						align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
					},
					['neo-tree'] = { event = 'BufWipeout' },
					Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
				},
			},
			version = '^1.0.0',
		},
		{
			"nvim-lualine/lualine.nvim",
			config = function()
				require('lualine').setup {
					options = {
						theme = bubbles_theme,
						component_separators = '',
						section_separators = { left = '', right = '' },
					},
					sections = {
						lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
						lualine_b = { 'filename', 'branch' },
						lualine_c = {
							'%=',
						},
						lualine_x = {},
						lualine_y = { 'filetype', 'progress' },
						lualine_z = {
							{ 'location', separator = { right = '' }, left_padding = 2 },
						},
					},
					inactive_sections = {
						lualine_a = { 'filename' },
						lualine_b = {},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = { 'location' },
					},
					tabline = {},
					extensions = {},
					disabled_filetypes = {
					},
					ignore_focus = {
					},
					globalstatus = true,
				}
			end,
		},

		{
			'goolord/alpha-nvim',
			dependencies = {
				'echasnovski/mini.icons',
				'nvim-lua/plenary.nvim'
			},
			config = function()
				require 'alpha'.setup(require 'alpha.themes.theta'.config)
			end
		},

		{
			"akinsho/bufferline.nvim",
			version = "*",
		},

		{
			'numToStr/Comment.nvim',
			opts = {},
			config = function()
				require('Comment').setup({
					padding = true,
					sticky = true,
					ignore = nil,

					toggler = {
						line = 'gcc',
						block = 'gbc',
					},

					opleader = {
						line = 'gc',
						block = 'gb',
					},

					-- extra mapping
					extra = {
						above = 'gcO',
						below = 'gco',
						eol = 'gcA',
					},

					-- enable keybinds
					mappings = {
						basic = true,
						extra = true,
					},

					pre_hook = nil,
					post_hook = nil,
				})
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require('nvim-treesitter').setup({
					ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", },
					sync_install = true,

					auto_install = true,

					-- ignore_install = { "javascript" },

					highlight = {
						enable = true,

						disable = function(lang, buf)
							local max_filesize = 100 * 1024 -- 100 KB
							local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
							if ok and stats and stats.size > max_filesize then
								return true
							end
						end,

						additional_vim_regex_highlighting = false,
					},
				})
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp"
		},
		{
			"hrsh7th/nvim-cmp",
			requires = {
				{ 'hrsh7th/cmp-nvim-lsp' }, -- LSP source
				{ 'hrsh7th/cmp-buffer' }, -- Buffer source
				{ 'hrsh7th/cmp-path' }, -- Path source
				{ 'L3MON4D3/LuaSnip' }, -- luasnip
			},
			config = function()
				require('cmp').setup({
					sources = {
						{ name = 'nvim_lsp' },
						{ name = 'buffer' },
						{ name = 'path' },
						{ name = 'cmp_snippet' },
						{ name = 'cmp_treesitter' },
						{ name = 'luasnip' },
					},
					snippet = {
						expand = function(args)
							require('luasnip').lsp_expand(args.body)
						end,
					},
					mapping = require('cmp').mapping.preset.insert({
						['<C-b>'] = require('cmp').mapping.scroll_docs(-4),
						['<C-f>'] = require('cmp').mapping.scroll_docs(4),
						['<C-Space>'] = require('cmp').mapping.complete(),
						['<C-e>'] = require('cmp').mapping.abort(),
						['<CR>'] = require('cmp').mapping.confirm({ select = true }),
					})
				})
			end,
		},
		{
			'neovim/nvim-lspconfig',
			requires = {
				{ 'hrsh7th/nvim-cmp' },
				{ 'hrsh7th/cmp-nvim-lsp' },
			},
		},
		{
			'hrsh7th/cmp-nvim-lsp',
			requires = {
				{ 'hrsh7th/nvim-cmp' },
			},
		},
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('telescope').setup()
			end,
		},
		{
			"xiyaowong/transparent.nvim",
			lazy = false,
			priority = 999,
			config = function()
				require("transparent").setup({
					groups = {
						"Normal",
						"NormalNC",
						"Comment",
						"Constant",
						"Special",
						"Identifier",
						"Statement",
						"PreProc",
						"Type",
						"Underlined",
						"Todo",
						"String",
						"Function",
						"Conditional",
						"Repeat",
						"Operator",
						"Structure",
						"LineNr",
						"NonText",
						"SignColumn",
						"CursorLine",
						"CursorLineNr",
						"StatusLine",
						"StatusLineNC",
						"EndOfBuffer",
					},
					extra_groups = { "NormalFloat", "NvimTreeNormal" },
					exclude_groups = {},
				})
				require("transparent").clear_prefix("NvimTreeNormal")
			end,
		},
		{
			'boganworld/crackboard.nvim',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('crackboard').setup({
					session_key = '5ad3531a98c2429b084bb080dbc7639c0e2fb68a2664f9db9c936a71bd5b5cc7',
				})
			end,
		},
	},
	install = { colorscheme = { "monochrome" } },
	checker = { enabled = true },
})

-- Colorscheme
vim.opt.background = "dark" -- switch between dark or light
vim.cmd("colorscheme monochrome")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

-- CMP languages
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua
require('lspconfig').lua_ls.setup {}

-- Go
require('lspconfig').gopls.setup {
	capabilities = capabilities,
}

-- JavaScript, ReactJS, TypeScript
require('lspconfig').tsserver.setup {
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = false,
		},
	},
}

-- C, C++
require('lspconfig').clangd.setup { capabilities = capabilities, }

-- Rust
require('lspconfig').rust_analyzer.setup { capabilities = capabilities }

-- Markdown
require('lspconfig').marksman.setup { capabilities = capabilities }

-- Zig (zls)
require('lspconfig').zls.setup { capabilities = capabilities }

-- Assembly (asm_lsp)
require('lspconfig').asm_lsp.setup { capabilities = capabilities }

-- Telescope Keybinds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- hop keybinds
local hop = require('hop')
local directions = require('hop.hint').HintDirection

-- modern autoformat on save
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format { async = false, id = args.data.client_id }
			end,
		})
	end
})

-- Keybindings
vim.api.nvim_set_keymap("n", "fw", ":HopWord<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fc", ":HopChar1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fb", ":HopChar2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fp", ":HopPattern<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fl", ":HopLine<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fs", ":HopLineStart<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fa", ":HopAnywhere<CR>", { noremap = true, silent = true })

-- Multi-window support
vim.api.nvim_set_keymap("n", "fW", ":HopWordMW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fC", ":HopChar1MW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fB", ":HopChar2MW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fP", ":HopPatternMW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fL", ":HopLineMW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fS", ":HopLineStartMW<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fA", ":HopAnywhereMW<CR>", { noremap = true, silent = true })

-- Clipboard

-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true })

-- BarBar keybinds
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer

-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Mouse Support
vim.opt.mouse = "a"

-- Colorscheme
vim.opt.termguicolors = true

-- Clear `/` search pattern
vim.api.nvim_set_keymap('n', '<leader>s', ':let @/ = ""<CR>', { silent = true })

-- Word Wrapping
vim.o.textwidth = 0
vim.o.wrapmargin = 0
-- visual wrap (no real line cutting is made)
vim.o.linebreak = true -- breaks by word rather than character
