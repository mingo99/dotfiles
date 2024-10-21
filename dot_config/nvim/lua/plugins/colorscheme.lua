return {
  -- Transparent for colorscheme
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      -- transparent for statusline
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,
    },
  },
}
