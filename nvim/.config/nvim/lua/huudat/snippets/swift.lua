local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Access Control
  s("pub", fmt("public {}", { i(0) })),
  s("priv", fmt("private {}", { i(0) })),

  -- Control Flow
  s("if", fmt([[
    if {} {{
      {}
    }}
    {}
  ]], { i(1), i(2), i(0) })),

  s("ifl", fmt([[
    if let {} = {} {{
      {}
    }}
    {}
  ]], { i(1, "value"), rep(1), i(2), i(0) })),

  s("ifcl", fmt([[
    if case let {} = {} {{
      {}
    }}
    {}
  ]], { i(1, "value"), rep(1), i(2), i(0) })),

  -- Functions
  s("func", fmt([[
    func {}({}){} {{
      {}
    }}
  ]], { i(1, "name"), i(2), i(3), i(0) })),

  s("funca", fmt([[
    func {}({}) async{} {{
      {}
    }}
  ]], { i(1, "name"), i(2), i(3), i(0) })),

  -- Guards
  s("guard", fmt([[
    guard {} else {{
      {}
    }}
    {}
  ]], { i(1), i(2), i(0) })),

  s("guardl", fmt([[
    guard let {} = {} else {{
      {}
    }}
    {}
  ]], { i(1, "value"), rep(1), i(2), i(0) })),

  -- Entry Point
  s("main", fmt([[
    @main public struct {} {{
      public static func main() {{
        {}
      }}
    }}
    {}
  ]], { i(1, "App"), i(2), i(0) })),
}
