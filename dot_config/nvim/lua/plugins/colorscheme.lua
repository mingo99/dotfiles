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
      on_colors = function(colors)
        -- transparent for statusline
        colors.bg_statusline = colors.none
        colors.comment = "#6272a4"
      end,
      on_highlights = function(hl, colors)
        local commentColor = colors.comment
        hl.LineNr = {
          fg = commentColor,
        }
        hl.LineNrAbove = {
          fg = commentColor,
        }
        hl.LineNrBelow = {
          fg = commentColor,
        }
        hl.DiagnosticUnnecessary = { fg = commentColor }
      end,
    },
  },
}
