local cmdline_width = 80

return {
  "folke/noice.nvim",
  opts = {
    views = {
      mini = { win_options = { winblend = 0 } },
      cmdline_popup = {
        position = {
          row = 5,
          col = "50%",
        },
        size = {
          width = cmdline_width,
          height = "auto",
        },
      },
      cmdline_popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        }, -- when auto, then it will be positioned to the cmdline or cursor
        size = {
          width = cmdline_width,
          height = 10,
        },
        win_options = {
          winhighlight = {
            Normal = "Normal", -- change to NormalFloat to make it look like other floats
            FloatBorder = "DiagnosticInfo", -- border highlight
          },
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
      },
      -- split = {
      --   scrollbar = false,
      -- },
    },
  },
}
