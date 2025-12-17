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
    { "ryanoasis/vim-devicons", lazy = true },
    { "kyazdani42/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim" },
    -- { "pieces-app/plugin_neovim" },
    { "EinfachToll/DidYouMean" },
    { "Yggdroot/indentLine" },
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
        },
        config = function()
            require( "nvim-tree" ).setup()
        end
    },
    { "tpope/vim-surround" },
    { "mtth/scratch.vim" },
    { "nvim-lualine/lualine.nvim" },
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
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
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
    { "mxw/vim-jsx",                              ft = "javascript" },
    { "lfilho/cosco.vim",                         ft = "javascript" },
    { "othree/html5.vim",                         ft = "html" },
    { "leafo/moonscript-vim",                     ft = "moonscript" },
    { "tpope/vim-endwise",                        ft = "ruby" },
    { "cfc-servers/gluafixer.vim",                ft = "lua" },
    { "metakirby5/codi.vim",                      cmd = "Codi" },
    { "google/vim-searchindex",                   event = "BufReadPost" },
    { "mg979/vim-visual-multi",                   event = "BufReadPost" },
    { "tpope/vim-sleuth",                         event = "InsertEnter" },
    { "tpope/vim-fugitive",                       event = "BufWritePost" },
    { "mhinz/vim-signify",                        event = "BufWritePost" },

    -- LSP
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
    },
    "neovim/nvim-lspconfig",

    -- Autocompletion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
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
    { event = "FileType", pattern = "javascript",                                 cmd = "let g:jsx_ext_required = 0" },
    { event = "FileType", pattern = "html,ruby,javascript,typescript,jsx,svelte", cmd = "setlocal ts=4 sts=4 sw=4" },
    { event = "FileType", pattern = "python",                                     cmd = "setlocal ts=4 sts=4 sw=4 tw=0" },
    { event = "FileType", pattern = "css,yaml",                                   cmd = "setlocal ts=2 sts=2 sw=2 expandtab" }
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
-- vim.g.ale_virtualtext_cursor = 0

-- ---- LSP CONFIGURATION ----
require( "mason" ).setup()

vim.lsp.config( "lua_ls", {
    before_init = function( init_params, config )
        init_params.initializationOptions = init_params.initializationOptions or {}
        init_params.initializationOptions.storagePath = "~/.cache/luals"
    end
} )
vim.lsp.enable( "lua_ls" )

-- local bufopts = { noremap = true, silent = true }
vim.keymap.set( "n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { silent = true } )
-- vim.keymap.set( "n", "[g", vim.diagnostic.goto_prev, { silent = true } )
-- vim.keymap.set( "n", "]g", vim.diagnostic.goto_next, { silent = true } )
-- vim.keymap.set( "n", "gd", function() vim.cmd( "tab split | lua vim.lsp.buf.definition()" ) end, bufopts )
-- vim.keymap.set( "n", "gy", vim.lsp.buf.type_definition, { silent = true } )
-- vim.keymap.set( "n", "gi", vim.lsp.buf.implementation, { silent = true } )
-- vim.keymap.set( "n", "gr", vim.lsp.buf.references, { silent = true } )
vim.keymap.set( "v", "<leader>f", function() vim.lsp.buf.format( { async = true } ) end, bufopts )
vim.keymap.set( "n", "<leader>f", function() vim.lsp.buf.format( { async = true } ) end, bufopts )
-- ---- END LSP CONFIGURATION ----

-- ---- AUTOCOMPLETION CONFIGURATION ----
local cmp = require( "cmp" )

require( "luasnip.loaders.from_vscode" ).lazy_load()

cmp.setup( {
    snippet = {
        expand = function( args )
            require( "luasnip" ).lsp_expand( args.body )
        end,
    },
    mapping = cmp.mapping.preset.insert( {
        ["<C-b>"] = cmp.mapping.scroll_docs( -4 ),
        ["<C-f>"] = cmp.mapping.scroll_docs( 4 ),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm( { select = true } ),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
})
-- ---- END AUTOCOMPLETION CONFIGURATION ----

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require( "lualine" ).setup( {
    options = {
        theme = require( "lualine.themes.OceanicNext" )
    },
    sections = {
        lualine_a = {
            {
                "diagnostics",

                sources = { "nvim_lsp" },

                sections = { "error", "warn", "info", "hint" },

                diagnostics_color = {
                    error = "DiagnosticError",
                    warn  = "DiagnosticWarn",

                    info  = "DiagnosticInfo",
                    hint  = "DiagnosticHint",
                },

                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            }
        }
    }
} )

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

local function on_stderr( _, data )
    if not data then return end
    if #data == 0 then return end
    if #data == 1 and #data[1] == 0 then return end

    print( table.concat( data, "\n" ) )
    vim.api.nvim_err_writeln( "Error pulling glua-api-snippets (:messages to see output)" )
end

vim.fn.jobstart(
    "timeout --signal=KILL 10s git pull --quiet --recurse-submodules --no-rebase origin lua-language-server-addon",
    { cwd = "/home/brandon/.cache/luals/addonManager/addons/garrysmod/module/glua-api-snippets", on_stderr = on_stderr }
)

