return {
  "folke/snacks.nvim",
  keys = {
    {
      "<space>sB",
      function()
        local curr_path = vim.fn.expand("%:p")
        Snacks.picker.grep({ ---@diagnostic disable-line: undefined-field
          finder = "grep",
          buffers = false,
          ignored = true,
          hidden = true,
          live = true,
          need_search = false,
          supports_live = true,
          layout = { preview = false, preset = "ivy_split" }, ---@diagnostic disable-line
          dirs = { curr_path },
          title = "Grep Lines",
          format = function(item)
            local ret = {} ---@type snacks.picker.Highlight[]
            local line_count = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
            local idx = Snacks.picker.util.align(tostring(item.idx), #tostring(line_count), { align = "right" })
            ret[#ret + 1] = { idx, "LineNr", virtual = true }
            ret[#ret + 1] = { "  ", virtual = true }
            if item.line then
              Snacks.picker.highlight.format(item, item.line, ret)
              table.insert(ret, { " " })
            end
            return ret
          end,
        })
      end,
      desc = "Grep current buffer",
    },
  },
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    notifier = { style = "fancy" },
    picker = {
      formatters = { file = { truncate = 100 } },
      layouts = { default = { layout = { width = 0.9, height = 0.9 } } },
      matcher = { frecency = true },
      win = {
        input = {
          keys = {
            ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-p>"] = { "history_back", mode = { "i", "n" } },
          },
        },
      },
    },
    styles = { lazygit = { width = 0, height = 0 } },
  },
}
