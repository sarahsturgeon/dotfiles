vim.cmd( [[
syntax enable
]] )

vim.g.mapleader = ","

local lazypath = vim.fn.stdpath( "data" ) .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat( lazypath ) then
    vim.fn.system( {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    } )
end
vim.opt.rtp:prepend( lazypath )

local plugins = {
    -- { "dstein64/vim-startuptime" },
    { "github/copilot.vim" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    { "neoclide/coc.nvim", branch = "release" },
    { "EinfachToll/DidYouMean" },
    { "Yggdroot/indentLine" },
    {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      opts = {
      },
    },
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
        },
        config = function()
            require( "nvim-tree" ).setup()
        end
    },
    -- { "mtth/scratch.vim" },
    { "dense-analysis/ale" },
    { "nvim-lualine/lualine.nvim" },
    { "ggandor/leap.nvim" },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",     -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            animation = false
        },
    },
    { "nvim-lua/plenary.nvim" },
    { "mateuszwieloch/automkdir.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        keys = {
            { "<C-i>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
            { "<C-o>", "<cmd>Telescope buffers<CR>", desc = "Find Buffer" },
            { "<C-p>", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" }
        },
        config = function()
            local telescope = require( "telescope" )
            telescope.setup( {
                defaults = {
                    file_previewer = require( "telescope.previewers" ).cat.new,
                }
            } )

            telescope.load_extension( "fzf" )
        end
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-treesitter/nvim-treesitter",          run = ":TSUpdate" },
    { "mxw/vim-jsx",                              ft = "javascript" },
    { "pangloss/vim-javascript",                  ft = "javascript" },
    { "lfilho/cosco.vim",                         ft = "javascript" },
    { "wuelnerdotexe/vim-astro",                  ft = "astro" },
    { "yaegassy/coc-astro",                       ft = "astro", build = "yarn install --frozen-lockfile" },
    { "othree/html5.vim",                         ft = "html" },
    { "evanleck/vim-svelte",                      ft = { "javascript", "svelte" }, branch = "main" },
    { "hashivim/vim-terraform",                   ft = { "terraform", "tf" } },
    { "tpope/vim-markdown",                       ft = "markdown" },
    { "leafo/moonscript-vim",                     ft = "moonscript" },
    { "slim-template/vim-slim",                   ft = "slim" },
    { "tpope/vim-endwise",                        ft = "ruby" },
    { "cfc-servers/gluafixer.vim",                ft = "lua" },
    { "metakirby5/codi.vim",                      cmd = "Codi" },
    { "google/vim-searchindex",                   event = "BufReadPost" },
    { "mg979/vim-visual-multi",                   event = "BufReadPost" },
    { "petertriho/nvim-scrollbar",                event = "BufReadPost" },
    { "tpope/vim-sleuth",                         event = "InsertEnter" },
    { "tpope/vim-fugitive",                       event = "BufWritePost" },
    { "mhinz/vim-signify",                        event = "BufWritePost" },
}

require( "lazy" ).setup( plugins, opts )

-- ---- BEGIN BASE CONfIGURATION ----
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.wildmenu = true
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.history = 2000
vim.opt.undolevels = 2000
vim.opt.spelllang = "en_us"

vim.opt.laststatus = 2
vim.opt.showtabline = 0
vim.opt.backspace = "2"
vim.opt.encoding = "utf-8"

-- Tabs to spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.updatetime = 300

-- vim.opt.t_Co = 256

local TEMP = vim.env.TEMP
vim.opt.directory = TEMP .. "/.vim/.dir/"

vim.opt.backup = true
vim.opt.backupdir = TEMP .. "/.vim/.backup/"

if vim.fn.has( "persistent_undo" ) == 1 then
    vim.opt.undodir = TEMP .. "/.vim/.undo/"
    vim.opt.undofile = true
end

-- ---- END BASE CONFIGURATION ----

-- ---- BEGIN REMAPPING ----
vim.keymap.set( "n", "<leader><leader>", ":nohlsearch<CR>", { silent = true } )
vim.keymap.set( "n", "<leader>s", ":set spell!<CR>", { silent = true } )
vim.keymap.set( "n", "<C-W>m", ":wincmd _<Bar>wincmd <Bar><CR>", { silent = true } )
vim.keymap.set( "n", "T", "$", { silent = true } )
vim.keymap.set( "n", "Y", "^", { silent = true } )
vim.keymap.set( "n", "<S-k>", "<Nop>", {} )
vim.cmd [[
command W w
command Q q
command Qa qa
command Wa wa
command Wq wq
command Wqa wqa
command WQa wqa
command WQA wqa
]]
vim.keymap.set( "n", "<C-t>", ":tabnew split<CR>", {} )
vim.keymap.set( "n", "H", "gT", {} )
vim.keymap.set( "n", "L", "gt", {} )
vim.keymap.set( "n", "<C-j>", "<C-d>", {} )
vim.keymap.set( "n", "<C-k>", "<C-u>", {} )
vim.keymap.set( "n", "(", "<C-o>", {} )
vim.keymap.set( "n", ")", "<C-i>", {} )
-- ---- END REMAPPING ----


-- ---- BEGIN PLUGIN CONFIGURATION ----
vim.g.indentLine_color_term = 239
vim.opt.termguicolors = true

-- Styling
vim.cmd( [[
colorscheme tokyonight
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=9
hi SignColumn guibg=none ctermbg=none

"hi DiffAdd           cterm=bold ctermbg=none ctermfg=119
"hi DiffDelete        cterm=bold ctermbg=none ctermfg=167
"hi DiffChange        cterm=bold ctermbg=none ctermfg=227
"hi Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
hi Normal guibg=NONE ctermbg=NONE
]] )

vim.g.signify_sign_delete = "-"
vim.g.signify_cursorhold_normal = 1
vim.g.signify_cursorhold_insert = 1

local autocmds = {
    { event = "FileType", pattern = "javascript",                                     cmd = "let g:jsx_ext_required = 0" },
    { event = "FileType", pattern = "html,ruby,javascript,typescript,jsx,tsx,svelte", cmd = "setlocal ts=2 sts=2 sw=2" },
    { event = "FileType", pattern = "python",                                         cmd = "setlocal ts=4 sts=4 sw=4 tw=0" },
    { event = "FileType", pattern = "css,yaml",                                       cmd =
    "setlocal ts=2 sts=2 sw=2 expandtab" }
}

local autocmd_group = vim.api.nvim_create_augroup( "filetypes", { clear = true } )

for _, autocmd in pairs( autocmds ) do
    vim.api.nvim_create_autocmd( autocmd.event, {
        callback = function() vim.cmd( autocmd.cmd ) end,
        pattern = autocmd.pattern,
        group = autocmd_group
    } )
end

vim.opt.tags = "tags"
vim.g.ale_virtualtext_cursor = 0

vim.keymap.set( "n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true } )
vim.keymap.set( "n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true } )
vim.keymap.set( "n", "gd", "<Plug>(coc-definition)", { silent = true } )
vim.keymap.set( "n", "gy", "<Plug>(coc-type-definition)", { silent = true } )
vim.keymap.set( "n", "gi", "<Plug>(coc-implementation)", { silent = true } )
vim.keymap.set( "n", "gr", "<Plug>(coc-references)", { silent = true } )
vim.keymap.set( "v", "<leader>f", "<Plug>(coc-format-selected)", {} )
vim.keymap.set( "n", "<leader>f", "<Plug>(coc-format-selected)", {} )
vim.keymap.set( "n", "<space>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true } )

function _G.show_docs()
    local cw = vim.fn.expand( "<cword>" )
    if vim.fn.index( { "vim", "help" }, vim.bo.filetype ) >= 0 then
        vim.api.nvim_command( "h " .. cw )
    elseif vim.api.nvim_eval( "coc#rpc#ready()" ) then
        vim.fn.CocActionAsync( "doHover" )
    else
        vim.api.nvim_command( "!" .. vim.o.keywordprg .. " " .. cw )
    end
end

vim.keymap.set( "n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true } )

vim.api.nvim_create_augroup( "CocGroup", {} )
vim.api.nvim_create_autocmd( "CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
} )

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require( "lualine" ).setup( {
    options = {
        theme = require( "lualine.themes.OceanicNext" )
    },
    sections = {
        lualine_a = {
            {
                "diagnostics",

                -- Table of diagnostic sources, available sources are:
                --   "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", "coc", "ale", "vim_lsp".
                -- or a function that returns a table as such:
                --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                sources = { "ale", "coc", "nvim_lsp" },

                -- Displays diagnostics for the defined severity types
                sections = { "error", "warn", "info", "hint" },

                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = "DiagnosticError", -- Changes diagnostics" error color.
                    warn  = "DiagnosticWarn",  -- Changes diagnostics" warn color.
                    info  = "DiagnosticInfo",  -- Changes diagnostics" info color.
                    hint  = "DiagnosticHint",  -- Changes diagnostics" hint color.
                },

                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                colored = true,           -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false,   -- Show diagnostics even if there are none.
            }
        }
    }
} )


-- For barbar?
require( "bufferline" ).setup( {
    animation = true,
    auto_hide = true,
    closeable = false
} )

-- ,b to open a new buffer
vim.keymap.set( "n", "<leader>b", ":enew<CR>", { noremap = true } )

-- C-o to open buffer picker
vim.keymap.set( "n", "<C-o>", "<Cmd>BufferPick<CR>", { noremap = true, silent = true } )

-- C-h to go to previous buffer, C-l to go to next buffer
vim.keymap.set( "n", "<C-h>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true } )
vim.keymap.set( "n", "<C-l>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true } )

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new, empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Require leap and set its primary keybind to "r"
require( "leap" )
vim.keymap.set( "n",          "r", "<Plug>(leap)" )
vim.keymap.set( "n",          "R", "<Plug>(leap-from-window)" )
vim.keymap.set( { "x", "o" }, "r", "<Plug>(leap-forward)" )
vim.keymap.set( { "x", "o" }, "R", "<Plug>(leap-backward)" )
