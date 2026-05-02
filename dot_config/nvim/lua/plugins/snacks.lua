local function grep_current_file()
  local curr_path = vim.fn.expand("%:p")
  Snacks.picker.grep({ ---@diagnostic disable-line: undefined-field
    title = "Grep Lines",
    finder = "grep",
    ignored = true,
    hidden = true,
    live = true,
    supports_live = true,
    need_search = false,
    dirs = { curr_path },
    layout = { preview = false }, ---@diagnostic disable-line
    format = function(item)
      local ret = {} ---@type snacks.picker.Highlight[]
      local line_count = vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf())
      local idx = Snacks.picker.util.align(tostring(item.idx), #tostring(line_count), { align = "right" })
      ret[#ret + 1] = { idx, "LineNr", virtual = true }
      ret[#ret + 1] = { "  ", virtual = true }
      if item.line then
        if item.positions then
          local offset = Snacks.picker.highlight.offset(ret)
          Snacks.picker.highlight.matches(ret, item.positions, offset)
        end
        Snacks.picker.highlight.format(item, item.line, ret)
        table.insert(ret, { " " })
      end
      return ret
    end,
  })
end

return {
  "folke/snacks.nvim",
  keys = {
    -- stylua: ignore start
    { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sB", function() grep_current_file() end, desc = "Grep current buffer"},
    -- stylua: ignore end
  },
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    image = { enabled = true },
    notifier = { style = "fancy" },
    picker = {
      sources = { buffers = { layout = { preset = "ivy" } } },
      formatters = { file = { truncate = 100 } },
      layouts = { default = { layout = { width = 0.9, height = 0.9 } } },
      matcher = { cwd_bonus = true, frecency = true, history_bonus = true },
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
