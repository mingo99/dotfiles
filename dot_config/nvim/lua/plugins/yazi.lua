return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>yy",
        "<cmd>Yazi<cr>",
        desc = "Open the file manager",
      },
      {
        -- Open in the current working directory
        "<leader>yc",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<leader>e",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },

    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,

      -- enable these if you are using the latest version of yazi
      use_ya_for_events_reading = true,
      use_yazi_client_id_flag = true,

      -- the type of border to use for the floating window. Can be many values,
      -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
      -- more information, see :h nvim_open_win
      yazi_floating_window_border = "rounded",

      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
}
