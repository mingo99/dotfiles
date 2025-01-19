return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>sB", "<cmd>FzfLua grep_curbuf previewer=false<cr>", desc = "Buffer" },
  },
  opts = {
    winopts = {
      preview = {
        horizontal = "right:55%",
      },
    },
    grep = {
      no_header = true,
    },
    files = {
      no_header = true,
    },
  },
}
