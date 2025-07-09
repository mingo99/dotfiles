return {
  "saghen/blink.cmp",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "xzbdmw/colorful-menu.nvim", opts = {} },
  opts = {
    cmdline = { completion = { menu = { auto_show = true } } },
    completion = {
      -- list = { selection = { preselect = false, auto_insert = true } },
      documentation = { auto_show = true, window = { border = "rounded" } },
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
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      use_frecency = true,
      use_proximity = true,
      sorts = {
        "exact",
        "score",
        "sort_text",
      },
      prebuilt_binaries = { download = true },
    },
  },
}
