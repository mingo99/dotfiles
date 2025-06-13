return {
  "saghen/blink.cmp",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "xzbdmw/colorful-menu.nvim", opts = {} },
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
        border = "rounded",
        winblend = 0,
      },
    },
    keymap = {
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    cmdline = {
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
    -- sources = {
    --   providers = {
    --     snippets = { score_offset = 1000 },
    --   },
    -- },
  },
}
