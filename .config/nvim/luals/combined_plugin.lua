local _, _, plugin_paths = ...

local handlers = {
    OnSetText = {},
    OnTransformAst = {},
    ResolveRequire = {},
}

local combined = {}

function combined.OnSetText( uri, text )
    local diffs = {}

    for _, handler in ipairs( handlers.OnSetText ) do
        local result = handler( uri, text )
        if type( result ) == "string" then return result end

        for _, diff in ipairs( result or {} ) do
            diffs[#diffs + 1] = diff
        end
    end

    if #diffs == 0 then return nil end

    return diffs
end

function combined.OnTransformAst( uri, ast )
    local transformed

    for _, handler in ipairs( handlers.OnTransformAst ) do
        transformed = handler( uri, transformed or ast ) or transformed
    end

    return transformed
end

function combined.ResolveRequire( uri, name )
    for _, handler in ipairs( handlers.ResolveRequire ) do
        local result = handler( uri, name )
        if result then return result end
    end
end

for _, path in ipairs( plugin_paths or {} ) do
    local environment = setmetatable( {}, { __index = _ENV } )
    local chunk = assert( loadfile( path, "t", environment ) )
    chunk( ... )

    for event, event_handlers in pairs( handlers ) do
        local handler = rawget( environment, event )
        if handler then event_handlers[#event_handlers + 1] = handler end
    end
end

for event, event_handlers in pairs( handlers ) do
    -- luals_gmod_include reads LuaLS locals at a fixed stack depth
    local has_single_handler = #event_handlers == 1
    _ENV[event] = has_single_handler and event_handlers[1] or combined[event]
end
