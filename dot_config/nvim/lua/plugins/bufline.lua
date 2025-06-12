return {
  "akinsho/bufferline.nvim",
  keys = {
    { "gb", "<Cmd>BufferLinePick<CR>", desc = "Select buffer in view" },
  },
  opts = {
    options = {
      separator_style = { "", "" },
      indicator = { style = "none" },
      show_buffer_close_icons = false,
      diagnostics = false,
    },
  },
}
