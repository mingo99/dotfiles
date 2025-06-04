return {
  "folke/snacks.nvim",
  keymps = {},
  opts = {
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    notifier = {
      style = "fancy",
    },
    picker = {
      layouts = {
        default = { layout = { width = 0.9, height = 0.9 } },
      },
      matcher = { frecency = true },
      sources = {
        grep_buffer = {
          finder = "grep",
          format = "file",
          buffers = false,
          regex = true,
          live = true,
          dirs = {},
        },
        files_with_symbols = {
          multi = { "files", "lsp_symbols" },
          layout = { preset = "default" },
          filter = {
            transform = function(p, filter)
              local symbol_pattern = filter.pattern:match("^.-@(.*)$")
              local line_nr_pattern = filter.pattern:match("^.-:(%d*)$")
              local search_pattern = filter.pattern:match("^.-#(.*)$")
              local pattern = symbol_pattern or line_nr_pattern or search_pattern

              if pattern then
                local item = p:current()
                if item and item.file then
                  filter.meta.buf = vim.fn.bufadd(item.file)
                end
              end

              if not filter.meta.buf then
                filter.source_id = 1
                return
              end

              if symbol_pattern then
                filter.pattern = symbol_pattern
                filter.current_buf = filter.meta.buf
                filter.source_id = 2
                return
              end

              if line_nr_pattern then
                filter.pattern = filter.pattern:gsub(":%d*$", "")
                filter.current_buf = filter.meta.buf
                filter.source_id = 1
                local item = p:current()
                if item then
                  item.pos = { tonumber(line_nr_pattern) or 1, 0 }
                  p.preview:loc()
                end
                return
              end

              if search_pattern then
                filter.pattern = filter.pattern:gsub("#.*$", "")
                filter.current_buf = filter.meta.buf
                filter.source_id = 1
                if search_pattern == "" then
                  return
                end
                local item = p:current()
                vim.api.nvim_buf_call(p.preview.win.buf, function()
                  vim.api.nvim_win_set_cursor(0, { 1, 0 })
                  local search = vim.fn.search(search_pattern, "ncW")
                  if search > 0 then
                    vim.cmd("/" .. search_pattern)
                    if vim.fn.line("w$") < search then
                      vim.api.nvim_win_set_cursor(0, { math.max(1, search - 8), 0 })
                    end
                    item.pos = { search, 0 }
                  end
                end)
                return
              end

              filter.source_id = 1
            end,
          },
        },
      },
    },
    styles = { lazygit = { width = 0, height = 0 } },
  },
}
