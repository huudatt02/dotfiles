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
    local ts_swap = require("nvim-treesitter-textobjects.swap")
    local ts_move = require("nvim-treesitter-textobjects.move")
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    local function map_select(lhs, query, desc)
      vim.keymap.set({ "x", "o" }, lhs, function()
        ts_select.select_textobject(query)
      end, { desc = desc })
    end

    local function map_swap(lhs, method, query, desc)
      vim.keymap.set("n", lhs, function()
        ts_swap[method](query)
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
    map_select("ak", "@block.outer", "around block")
    map_select("ik", "@block.inner", "inside block")

    map_select("ac", "@class.outer", "around class")
    map_select("ic", "@class.inner", "inside class")

    map_select("a?", "@conditional.outer", "around conditional")
    map_select("i?", "@conditional.inner", "inside conditional")

    map_select("af", "@function.outer", "around function")
    map_select("if", "@function.inner", "inside function")

    map_select("ao", "@loop.outer", "around loop")
    map_select("io", "@loop.inner", "inside loop")

    map_select("aa", "@parameter.outer", "around argument")
    map_select("ia", "@parameter.inner", "inside argument")

    -- textobjects swap
    map_swap(">A", "swap_next", "@parameter.inner", "Swap next argument")
    map_swap("<A", "swap_previous", "@parameter.inner", "Swap previous argument")

    -- textobjects move
    map_move("]k", "goto_next_start", "@block.outer", "Next block start")
    map_move("]f", "goto_next_start", "@function.outer", "Next function start")
    map_move("]a", "goto_next_start", "@parameter.inner", "Next argument start")

    map_move("]K", "goto_next_end", "@block.outer", "Next block end")
    map_move("]F", "goto_next_end", "@function.outer", "Next function end")
    map_move("]A", "goto_next_end", "@parameter.inner", "Next argument end")

    map_move("[k", "goto_previous_start", "@block.outer", "Previous block start")
    map_move("[f", "goto_previous_start", "@function.outer", "Previous function start")
    map_move("[a", "goto_previous_start", "@parameter.inner", "Previous argument start")

    map_move("[K", "goto_previous_end", "@block.outer", "Previous block end")
    map_move("[F", "goto_previous_end", "@function.outer", "Previous function end")
    map_move("[A", "goto_previous_end", "@parameter.inner", "Previous argument end")

    -- repeat move
    map_repeat_move(";", ts_repeat_move.repeat_last_move_next)
    map_repeat_move(",", ts_repeat_move.repeat_last_move_previous)

    map_repeat_move("f", ts_repeat_move.builtin_f_expr, { expr = true })
    map_repeat_move("F", ts_repeat_move.builtin_F_expr, { expr = true })
    map_repeat_move("t", ts_repeat_move.builtin_t_expr, { expr = true })
    map_repeat_move("T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
