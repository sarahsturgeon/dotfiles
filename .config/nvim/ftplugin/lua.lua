if vim.g.glua_ls_configured then return end
vim.g.glua_ls_configured = true

local home = vim.env.HOME
local checkout_parents = { home .. "/Code/dev", home .. "/Code/utils" }

local glua_api_branch = "lua-language-server-addon"
local glua_api_repo = "https://github.com/luttje/glua-api-snippets.git"
local glua_api_dir = vim.fn.stdpath( "data" ) .. "/glua-api-snippets"

local combined_plugin = vim.fn.stdpath( "config" ) .. "/luals/combined_plugin.lua"

local optional_libraries = {
    "gluatest/lua/gluatest",
    "gm_express/lua",
    "cfc_ulib/lua",
    "cfc_ulx/lua",
}

local optional_plugins = {
    "luals_gmod_include/plugin.lua",
}

local function existing_checkout_paths( relative_paths )
    local found = {}

    for _, parent in ipairs( checkout_parents ) do
        for _, relative_path in ipairs( relative_paths ) do
            local path = parent .. "/" .. relative_path
            if vim.uv.fs_stat( path ) then table.insert( found, path ) end
        end
    end

    return found
end

local function report_glua_api_error( _, data )
    local output = table.concat( data or {}, "\n" )
    if output == "" then return end

    vim.notify( "Error updating glua-api-snippets:\n" .. output, vim.log.levels.ERROR )
end

local function update_glua_api()
    if vim.uv.fs_stat( glua_api_dir ) then
        vim.fn.jobstart(
            { "timeout", "--signal=KILL", "10s", "git", "pull", "--quiet", "--no-rebase", "origin", glua_api_branch },
            { cwd = glua_api_dir, on_stderr = report_glua_api_error }
        )

        return
    end

    vim.fn.jobstart(
        { "git", "clone", "--quiet", "--depth", "1", "--branch", glua_api_branch, glua_api_repo, glua_api_dir },
        { on_stderr = report_glua_api_error }
    )
end

local libraries = { glua_api_dir .. "/library" }
vim.list_extend( libraries, existing_checkout_paths( optional_libraries ) )

local plugins = { glua_api_dir .. "/plugin.lua" }
vim.list_extend( plugins, existing_checkout_paths( optional_plugins ) )

vim.lsp.config( "lua_ls", {
    before_init = function( init_params )
        init_params.initializationOptions = init_params.initializationOptions or {}
        init_params.initializationOptions.trustByClient = true
    end,

    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                plugin = { combined_plugin },
                pluginArgs = plugins,
                special = {
                    include = "require",
                    IncludeCS = "require",
                },
            },
            hint = { enable = false },
            diagnostics = { disable = { "different-requires" } },
            workspace = {
                library = libraries,
                checkThirdParty = false,
            },
            format = {
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    tab_width = "4",
                    quote_style = "double",
                    max_line_length = "120",
                    end_of_line = "unset",
                    insert_final_newline = "false",
                    space_before_inline_comment = "1",
                    space_around_table_append_operator = "true",
                    space_before_function_call_single_arg = "none",
                    space_inside_function_call_parentheses = "true",
                    space_inside_function_param_list_parentheses = "true",
                },
            },
        },
    },
} )

update_glua_api()
