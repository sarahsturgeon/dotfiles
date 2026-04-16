-- treesitter indent is broken for lua, just use vim's default
vim.bo.indentexpr = ""

local home = vim.env.HOME

vim.lsp.config( "lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                plugin = { home .. "/Code/utils/luals_gmod_include/plugin.lua" },
                special = {
                    include = "require",
                    includeCS = "require",
                },
            },
            hint = { enable = false },
            workspace = {
                library = { home .. "/Code/utils/glua-api-snippets" },
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
