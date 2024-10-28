return {
  "folke/edgy.nvim",
  opts = {
    animate = { enabled = false },
    right = {
      { title = "Outline", ft = "Outline", size = { width = 0.25 } },
      {
        ft = "toggleterm",
        size = { width = 0.4 },
        filter = function(buf,win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
    },
    bottom = {
      {
        ft = "noice",
        size = { height = 0.3 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      {
        ft = "lazyterm",
        title = "LazyTerm",
        size = { height = 0.3 },
        filter = function(buf)
          return not vim.b[buf].lazyterm_cmd
        end,
      },
    },
  },
}
