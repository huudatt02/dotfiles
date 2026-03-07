local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function today()
	return os.date("%Y-%m-%d")
end

return {

	-- Javadoc Method
	s("javadoc_method", {
		t({ "/**", " * " }),
		i(1, "Description"),
		t({ "", " *", " * @param " }),
		i(2, "paramName"),
		t(" "),
		i(3, "paramDescription"),
		t({ "", " * @return " }),
		i(4, "returnDescription"),
		t({ "", " */" }),
	}),

	-- Javadoc Class
	s("javadoc_class", {
		t({ "/**", " * " }),
		i(1, "Description"),
		t({ "", " *", " * @author " }),
		i(2, "Author"),
		t({ "", " * @version " }),
		i(3, "*"),
		t({ "", " * @since " }),
		f(today),
		t({ "", " */" }),
	}),
}
