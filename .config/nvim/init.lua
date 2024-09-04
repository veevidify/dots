--region - backport old cfg
vim.cmd([[
	call pathogen#infect()
	syntax on
	filetype plugin indent on

	set nocompatible
	set clipboard+=unnamed
	set clipboard+=unnamedplus
	set fillchars+=stl:\ ,stlnc:\
	set list listchars=space:.,tab:»-,trail:.,extends:>,eol:¬
	set cursorline

	let g:ctrlp_working_path_mode = 'rw'
]])--

vim.opt.number=true
vim.opt.autoread=true
vim.opt.encoding="utf-8"
vim.opt.mouse="a"
vim.opt.laststatus=2
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.scrolloff=3

vim.g.mapleader = ","
vim.keymap.set("n", "<leader>n", ":noh<cr>", ns)

vim.keymap.set("n", "<Space>", ":", ns)
vim.keymap.set("n", "<Backspace>", "^", ns)

vim.keymap.set("n", "<leader>j", vim.cmd.split, ns)
vim.keymap.set("n", "<leader>l", vim.cmd.vsplit, ns)
vim.keymap.set("n", "<leader>b", "i```<cr>```<esc>ka", ns)

vim.g.markdown_fenced_languages = { 'html', 'python', 'ruby', 'vim', 'lua', 'yaml', 'json', 'javascript', 'typescript', 'java', 'scala', 'bash', 'sh' }

--region - load old cfg
local vimrc = vim.fn.stdpath("config") .. "/vimrc"
vim.cmd.source(vimrc)
--endregion

require("config.lazy")
local ns = { noremap = true, silent = true }

--region - fzf
vim.api.nvim_set_keymap("i", "jk", "<esc>", ns)
vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Open Files" })
-- with args
vim.keymap.set("n", "<c-G>", function() require('fzf-lua').files({ cwd = '~' }) end, { desc = "All Files" })
--endregion

--region - ui
vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox]])
vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.syntax "on"
--endregion

--region - telescope
local builtin = require('telescope.builtin')
vim.g.mapleader = ","
vim.keymap.set('n', '<leader>ff', builtin.find_files, ns)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, ns)
vim.keymap.set('n', '<leader>fb', builtin.buffers, ns)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, ns)
vim.keymap.set('n', '<M-F>', builtin.live_grep, {})

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
--endregion

--region - folding cfg
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
	provider_selector = function(bufnr, filetype, buftype)
		return {'treesitter', 'indent'}
	end
})
--endregion

--region - whitespace trim hook
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})
--endregion

--region - treesitter
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "html" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	-- ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
--endregion

--region - resize nvim
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<C-M-Left>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-M-Down>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-M-Up>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-M-Right>', require('smart-splits').resize_right)
--endregion

--region - movement hinting
local precognition = require("precognition")
precognition.toggle()
vim.keymap.set('n', '<M-S-H>', precognition.toggle, ns)
--endregion

--region - markdown table
require('mtoc').setup({})
--endregion

--region - markview nvim
require("markview").setup({
	modes = { "n", "no", "c" },

	hybrid_modes = {},

	-- This is nice to have
	callbacks = {
		on_enable = function (_, win)
			vim.wo[win].conceallevel = 2;
			vim.wo[win].concealcursor = "c";
		end
	}
})
--endregion

