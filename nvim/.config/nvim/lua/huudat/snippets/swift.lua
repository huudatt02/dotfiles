local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("ifcaselet", fmt([[
    if case let {} = {} {{
      {}
    }}
    {}
  ]], { i(1, "pattern"), i(2, "value"), i(2), i(0) })),

  s("funcasync", fmt([[
    func {}({}) async{} -> {} {{
      {}
    }}
  ]], { i(1, "name"), i(2), i(3), i(0) })),

  s("main", fmt([[
    @main public struct {} {{
      public static func main() {{
        {}
      }}
    }}
    {}
  ]], { i(1, "App"), i(2), i(0) })),
}
