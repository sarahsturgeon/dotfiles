vim.cmd( [[
syntax enable
]] )

vim.g.mapleader = ","

local lazypath = vim.fn.stdpath( "data" ) .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat( lazypath ) then
    vim.fn.system( {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    } )
end
vim.opt.rtp:prepend( lazypath )

local plugins = {
    -- { "dstein64/vim-startuptime" },
    { "github/copilot.vim" },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    -- LSP
    { "mason-org/mason.nvim", opts = {} },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            vim.lsp.config( "*", {
                capabilities = require( "blink.cmp" ).get_lsp_capabilities(),
            } )
            vim.lsp.enable( { "vtsls", "pyright", "lua_ls" } )
        end,
    },

    -- Completion
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            keymap = { preset = "default" },
            appearance = { nerd_font_variant = "mono" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { enabled = true },
        },
    },
    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        keys = {
            { "<leader>sc", function() require("nvim-silicon").shoot() end, mode = "x", desc = "Screenshot to clipboard + file" },
        },
        opts = {
            font = "FiraCode Nerd Font Mono",
            theme = "TwoDark",
            background = "#1e1e2e",
            no_window_controls = true,
            no_round_corner = true,
            pad_horiz = 0,
            pad_vert = 0,
            shadow_blur_radius = 0,
            to_clipboard = true,

            line_offset = function(args)
                return args.line1
            end,

            window_title = function()
                local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or ""
                local filepath = vim.fn.expand("%:p")
                return filepath:gsub("^" .. vim.pesc(git_root) .. "/", "")
            end,

            output = function()
                return "/Users/sarah/Desktop/Screenshots/silicon-" .. os.date("%Y-%m-%d-%H%M%S") .. ".png"
            end,
        },
    },
    { "EinfachToll/DidYouMean" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
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
            require( "nvim-tree" ).setup( {
                update_focused_file = {
                    enable = true,
                },
            } )
        end
    },
    -- { "mtth/scratch.vim" },
    { "nvim-lualine/lualine.nvim" },
    { url = "https://codeberg.org/andyg/leap.nvim" },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
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
        config = function()
            local telescope = require( "telescope" )
            telescope.setup( {
                defaults = {
                    file_previewer = require( "telescope.previewers" ).cat.new,
                }
            } )

            telescope.load_extension( "fzf" )

            vim.keymap.set( "n", "<C-i>", "<cmd>Telescope find_files<CR>", { desc = "Find Files" } )
            vim.keymap.set( "n", "<C-o>", "<cmd>Telescope buffers<CR>", { desc = "Find Buffer" } )
            vim.keymap.set( "n", "<C-p>", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" } )
        end
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require( "nvim-treesitter" ).install( {
                "javascript", "typescript", "tsx", "html", "css",
                "svelte", "astro", "terraform", "markdown", "markdown_inline",
                "ruby", "python", "lua", "json", "yaml", "bash",
            } )

            vim.api.nvim_create_autocmd( "FileType", {
                callback = function()
                    pcall( vim.treesitter.start )
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            } )
        end
    },
    { "wuelnerdotexe/vim-astro",                  ft = "astro" },
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
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "-" },
                topdelete    = { text = "-" },
                changedelete = { text = "~" },
            },
        },
    },
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
vim.opt.termguicolors = true

-- Styling
vim.cmd( [[
colorscheme tokyonight
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=9
hi SignColumn guibg=none ctermbg=none

hi Normal guibg=NONE ctermbg=NONE
]] )


local autocmds = {
    { event = "FileType", pattern = "html,ruby,javascript,typescript,javascriptreact,typescriptreact,svelte", cmd = "setlocal ts=2 sts=2 sw=2" },
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

-- ---- LSP KEYBINDINGS ----
local bufopts = { noremap = true, silent = true }
vim.keymap.set( "n", "[g", vim.diagnostic.goto_prev, bufopts )
vim.keymap.set( "n", "]g", vim.diagnostic.goto_next, bufopts )
vim.keymap.set( "n", "gd", vim.lsp.buf.definition, bufopts )
vim.keymap.set( "n", "gy", vim.lsp.buf.type_definition, bufopts )
vim.keymap.set( "n", "gi", "<cmd>Telescope lsp_document_symbols<CR>", bufopts )
vim.keymap.set( "n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts )
vim.keymap.set( "n", "K", vim.lsp.buf.hover, bufopts )
vim.keymap.set( "n", "<leader>rn", vim.lsp.buf.rename, bufopts )
vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, bufopts )
vim.keymap.set( { "n", "v" }, "<leader>f", function() vim.lsp.buf.format( { async = true } ) end, bufopts )
vim.keymap.set( "n", "<space>a", "<cmd>Telescope diagnostics<CR>", { silent = true, nowait = true } )

vim.api.nvim_create_autocmd( "CursorHold", {
    callback = function()
        for _, client in ipairs( vim.lsp.get_clients( { bufnr = 0 } ) ) do
            if client:supports_method( "textDocument/documentHighlight" ) then
                vim.lsp.buf.document_highlight()
                return
            end
        end
    end,
} )
vim.api.nvim_create_autocmd( "CursorMoved", {
    callback = function()
        if #vim.lsp.get_clients( { bufnr = 0 } ) > 0 then
            vim.lsp.buf.clear_references()
        end
    end,
} )

require( "lualine" ).setup( {
    options = {
        theme = require( "lualine.themes.OceanicNext" )
    },
    sections = {
        lualine_c = {
            {
                function()
                    local diag = vim.diagnostic.get( 0, { lnum = vim.api.nvim_win_get_cursor( 0 )[1] - 1 } )
                    if #diag == 0 then return "" end
                    local best = diag[1]
                    for _, d in ipairs( diag ) do
                        if d.severity < best.severity then best = d end
                    end
                    local msg = best.message:gsub( "%%", "%%%%" )
                    if #msg > 100 then msg = msg:sub( 1, 100 ) .. "..." end
                    return msg
                end,
                color = { fg = "#e06c75" },
            },
        },
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
  local no_args = data.file == ""
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_args and not directory then
    return
  end

  if directory then
    vim.cmd.enew()
    vim.cmd.bw(data.buf)
    vim.cmd.cd(data.file)
  end

  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Require leap and set its primary keybind to "r"
require( "leap" )
vim.keymap.set( "n",          "r", "<Plug>(leap)" )
vim.keymap.set( "n",          "R", "<Plug>(leap-from-window)" )
vim.keymap.set( { "x", "o" }, "r", "<Plug>(leap-forward)" )
vim.keymap.set( { "x", "o" }, "R", "<Plug>(leap-backward)" )
