local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function today()
    return os.date("%Y-%m-%d")
end

return {
    s("jdoc_method", fmt([[
/**
 * {}
 *
 * @param {} {}
 * @return {}
 */
]], {
        i(1, "Description"),
        i(2, "paramName"),
        i(3, "paramDescription"),
        i(4, "returnDescription"),
    })),

    s("jdoc_class", fmt([[
/**
 * {}
 *
 * @author {}
 * @version {}
 * @since {}
 */
]], {
        i(1, "Description"),
        i(2, "Author"),
        i(3, "*"),
        f(today),
    })),
}
