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

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colorscheme
    {
      "rebelot/kanagawa.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("kanagawa").setup({
          compile = false,
          undercurl = true,
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          typeStyle = {},
          transparent = true,
          dimInactive = false,
          terminalColors = true,
          colors = {
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
          },
          overrides = function(colors)
            return {}
          end,
          theme = "dragon",
          background = {
            dark = "wave",
            light = "lotus",
          },
        })
      end,
    },

    -- Icons
    {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({})
      end,
    },

    -- File Explorer
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      config = function()
        require("nvim-tree").setup({
          view = {
						adaptive_size = true,
          },
        })
      end,
    },

    -- Navigation
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

		-- Indent
		{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
		config = function()
			require("ibl").setup()
		end,
},

    -- Statusline
    {
      "nvim-lualine/lualine.nvim",
			config = function()
				require('lualine').setup({
					  options = {
    					icons_enabled = true,
    					theme = 'auto',
    					component_separators = { left = '', right = ''},
    					section_separators = { left = '', right = ''},
    					disabled_filetypes = {
      					statusline = {},
      					winbar = {},
    					},
    					ignore_focus = {},
    					always_divide_middle = true,
    					globalstatus = false,
    					refresh = {
      					statusline = 1000,
      					tabline = 1000,
      					winbar = 1000,
    					}
  					},
  					sections = {
    					lualine_a = {'mode'},
    					lualine_b = {'branch', 'diff', 'diagnostics'},
    					lualine_c = {'filename'},
    					lualine_x = {'encoding', 'fileformat', 'filetype'},
    					lualine_y = {'progress'},
    					lualine_z = {'location'}
  					},
  					inactive_sections = {
    					lualine_a = {''},
    					lualine_b = {},
    					lualine_c = {'filename'},
    					lualine_x = {'location'},
    					lualine_y = {},
    					lualine_z = {}
  					},
  					tabline = {},
  					winbar = {},
  					inactive_winbar = {},
  					extensions = {}
				})
			end,
    },

    -- Dashboard
    {
      "goolord/alpha-nvim",
      lazy = true,
    	config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    	end,
		},

    -- Bufferline
    {
      "akinsho/bufferline.nvim",
			version = "*",
    },

    -- Fuzzy Finder
    {
      "nvim-telescope/telescope.nvim",
      lazy = true,
      dependencies = {
        { "nvim-lua/plenary.nvim" },
      },
    },
		
		-- Comment
		{
			'numToStr/Comment.nvim',
    	opts = {},
			config = function()
				require('Comment').setup({
					padding = true, -- add space between comment and the line
					sticky = true, -- stick cursor to its position
					ignore = nil, -- lines to ignore while uncomment
					
					-- toggle mapping in NORMAL mode
					toggler = {
						line = 'gcc', -- line comment toggle
						block = 'gbc', -- block comment toggle
					},

					-- operator-pending mapping in NORMAL and VISUAL mode
					opleader = {
						line = 'gc', -- line comment
						block = 'gb', -- block comment
					},

					-- extra mapping
					extra = {
						above = 'gcO', -- add comment on the line above
						below = 'gco', -- add comment on the line below
						eol = 'gcA', -- add comment at the end of line
					},

					-- enable keybinds
					mappings = {
						basic = true,
						extra = true,
					},

					-- function to call before (un)comment
					pre_hook = nil,
					-- function to call after (un)comment
					post_hook = nil,
				})
			end,
		},

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
    	config = function()
				require('nvim-treesitter').setup({
  				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  				sync_install = false,

  				auto_install = true,

  				ignore_install = { "javascript" },

  				highlight = {
    				enable = true,

    				disable = { "c", "rust" },
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
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
},

		-- CMP Configuration
		{
			"hrsh7th/nvim-cmp",
			requires = {
    		{'hrsh7th/cmp-nvim-lsp'}, -- LSP source
    		{'hrsh7th/cmp-buffer'},   -- Buffer source
    		{'hrsh7th/cmp-path'},     -- Path source
				{'L3MON4D3/LuaSnip'}, -- luasnip
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
    		{'hrsh7th/nvim-cmp'},
    		{'hrsh7th/cmp-nvim-lsp'},
  		},
		},

		{
			'hrsh7th/cmp-nvim-lsp',
  		requires = {
    		{'hrsh7th/nvim-cmp'},
 			},
		},

		-- Finder Configuration
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('telescope').setup()
			end,
		},

    -- Transparency
    {
      "xiyaowong/transparent.nvim",
      lazy = false,
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
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- CMP languages
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua
-- require('lspconfig').lua_ls.setup {
--  capabilities = capabilities,
-- }

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
require('lspconfig').clangd.setup {
  capabilities = capabilities,
}

-- Rust
require('lspconfig').rust_analyzer.setup {
  capabilities = capabilities,
}

-- Markdown
require('lspconfig').marksman.setup {
  capabilities = capabilities,
}

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
-- 1
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
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

-- Colorscheme
vim.cmd("colorscheme kanagawa-dragon")

-- Mouse Support
vim.opt.mouse = "a"

-- Colorscheme
vim.opt.termguicolors = true

-- Nvim-tree Key Mappings
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- Clear `/` search pattern
vim.api.nvim_set_keymap('n', '<leader>s', ':let @/ = ""<CR>', { silent = true })

-- Word Wrapping
vim.o.textwidth = 0
vim.o.wrapmargin = 0
-- visual wrap (no real line cutting is made)
vim.o.linebreak = true -- breaks by word rather than character

-- Set highlight groups for transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "none" })

-- For terminal Neovim (not needed for GUI Neovim)
-- vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { ctermbg = "none" })

