return {
	{ "kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{ 'alexghergh/nvim-tmux-navigation',
		config = function()
			local nvim_tmux_nav = require('nvim-tmux-navigation')
			nvim_tmux_nav.setup {
				disable_when_zoomed = true -- defaults to false
			}
			vim.keymap.set('n', "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set('n', "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set('n', "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set('n', "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set('n', "<M-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
		end
	},
	{ "MunifTanjim/nui.nvim",
		lazy = true
	},
	{ "nvim-lua/plenary.nvim",
		lazy = true
	},
	{ "nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<F9>",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
			{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git Explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer Explorer",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						-- '.git',
						-- '.DS_Store',
						-- 'thumbs.db',
					},
					never_show = {},
				},
			},
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					-- ["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
					["P"] = { "toggle_preview", config = { use_float = false } },
					["F"] = "fuzzy_finder",
					["/"] = "fuzzy_finder_directory",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
		},
		config = function(_, opts)
			local function on_move(data)
				LazyVim.lsp.on_rename(data.source, data.destination)
			end

			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
	{ "ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end
	},
	{ "kevinhwang91/nvim-ufo",
		dependencies = 'kevinhwang91/promise-async'
	},
	{ "nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		},
	},
	{ "ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow"
	},
	{ "OXY2DEV/markview.nvim",
		lazy = false,      -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons"
		},

		headings = {
			enable = true,

			textoff = 0,
			shift_width = 0,

			heading_1 = {
				style = "simple",

				shift_char = "",
				padding_left = "",
				hl = "DiagnosticOk"
			},
			heading_2 = {
				padding_left = "",
				shift_char = "",
			},
			heading_3 = {
				padding_left = "",
				shift_char = "",
			}
		}
	},
	{ 'mrjones2014/smart-splits.nvim',
		-- to use Kitty multiplexer support, run the post install hook
		build = './kitty/install-kittens.bash'
	},
	{ "tris203/precognition.nvim",
		--event = "VeryLazy",
		opts = {
			startVisible = true,
			showBlankVirtLine = true,
			highlightColor = { link = "Comment" },
			hints = {
				Caret = { text = "^", prio = 2 },
				Dollar = { text = "$", prio = 1 },
				MatchingPair = { text = "%", prio = 5 },
				Zero = { text = "0", prio = 1 },
				w = { text = "w", prio = 10 },
				b = { text = "b", prio = 9 },
				e = { text = "e", prio = 8 },
				W = { text = "W", prio = 7 },
				B = { text = "B", prio = 6 },
				E = { text = "E", prio = 5 },
			},
			gutterHints = {
				G = { text = "G", prio = 10 },
				gg = { text = "gg", prio = 9 },
				PrevParagraph = { text = "{", prio = 8 },
				NextParagraph = { text = "}", prio = 8 },
			},
			disabled_fts = {
				"startify",
			},
		},
	},
	{ "hedyhli/markdown-toc.nvim",
		ft = "markdown",  -- Lazy load on markdown filetype
		cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
		opts = {
			-- Your configuration here (optional)
		},
	},
	{ 'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
	},
	{ 'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
	},
	{ "lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{ "junegunn/fzf",
		build = "./install --bin"
	}
}

