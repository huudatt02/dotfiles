return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  opts = {
    select = {
      lookahead = true,
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "V",
      },
      include_surrounding_whitespace = false,
    },
    move = {
      set_jumps = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    local ts_select = require("nvim-treesitter-textobjects.select")
    local ts_move = require("nvim-treesitter-textobjects.move")
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    local function map_select(lhs, query, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        ts_select.select_textobject(query, "textobjects")
      end, { desc = desc })
    end

    local function map_move(lhs, method, query, desc)
      vim.keymap.set({ "n", "x", "o" }, lhs, function()
        ts_move[method](query)
      end, { desc = desc })
    end

    local function map_repeat_move(lhs, rhs, map_opts)
      vim.keymap.set({ "n", "x", "o" }, lhs, rhs, map_opts or {})
    end

    -- textobjects select
    map_select("af", "@function.outer", "Around function")
    map_select("if", "@function.inner", "Inside function")
    map_select("ac", "@class.outer", "Around class")
    map_select("ic", "@class.inner", "Inside class")
    map_select("ao", "@loop.outer", "Around loop")
    map_select("io", "@loop.inner", "Inside loop")
    map_select("ai", "@conditional.outer", "Around conditional")
    map_select("ii", "@conditional.inner", "Inside conditional")
    map_select("aa", "@parameter.outer", "Around parameter")
    map_select("ia", "@parameter.inner", "Inside parameter")

    -- textobjects move
    map_move("]f", "goto_next_start", "@function.outer", "Next function start")
    map_move("]c", "goto_next_start", "@class.outer", "Next class start")
    map_move("]a", "goto_next_start", "@parameter.inner", "Next argument start")

    map_move("[f", "goto_previous_start", "@function.outer", "Previous function start")
    map_move("[c", "goto_previous_start", "@class.outer", "Previous class start")
    map_move("[a", "goto_previous_start", "@parameter.inner", "Previous argument start")

    -- repeat move
    map_repeat_move(";", ts_repeat_move.repeat_last_move_next)
    map_repeat_move(",", ts_repeat_move.repeat_last_move_previous)

    map_repeat_move("f", ts_repeat_move.builtin_f_expr, { expr = true })
    map_repeat_move("F", ts_repeat_move.builtin_F_expr, { expr = true })
    map_repeat_move("t", ts_repeat_move.builtin_t_expr, { expr = true })
    map_repeat_move("T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
