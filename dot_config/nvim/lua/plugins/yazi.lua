return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      { "<leader>yy", "<cmd>Yazi<cr>", desc = "Open the file manager" },
      { "<leader>yc", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
      { "<leader>yt", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
    },
    opts = {
      floating_window_scaling_factor = 1,
      open_for_directories = false,
      use_ya_for_events_reading = true,
      use_yazi_client_id_flag = true,
      yazi_floating_window_border = "rounded",
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
