local action_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    -- {
    --   "nvim-telescope/telescope-live-grep-args.nvim",
    --   -- This will not install any breaking changes.
    --   -- For major updates, this must be adjusted manually.
    --   version = "^1.0.0",
    -- },
    { "tsakirist/telescope-lazy.nvim" },
  },
  keys = {
    { "<leader>sp", "<cmd>Telescope lazy<cr>", desc = "Plugins list" },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim", -- add this value
      },
      mappings = {
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
        },
        i = {
          ["<C-u>"] = false,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<esc>"] = actions.close,
        },
      },
    },
    pickers = {
      current_buffer_fuzzy_find = {
        theme = "dropdown",
        previewer = false,
        -- sorting_strategy = "ascending",
        layout_config = {
          width = 0.8,
          height = 0.9,
        },
        tiebreak = function(entry1, entry2, prompt)
          local start_pos1, _ = entry1.ordinal:find(prompt)
          if start_pos1 then
            local start_pos2, _ = entry2.ordinal:find(prompt)
            if start_pos2 then
              return start_pos1 < start_pos2
            end
          end
          return false
        end,
        additional_args = { "--ignore-case", "--pcre2" },
      },
      buffers = {
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
      lsp_references = {
        trim_text = true,
      },
    },
    extensions = {
      lazy = {
        -- Optional theme (the extension doesn't set a default theme)
        -- theme = "dropdown",
        -- The below configuration options are the defaults
        show_icon = true,
        mappings = {
          open_in_browser = "<C-o>",
          open_in_file_browser = "<M-b>",
          open_in_find_files = "<C-f>",
          open_in_live_grep = "<C-g>",
          open_in_terminal = "<C-t>",
          open_plugins_picker = "<C-b>",
          open_lazy_root_find_files = "<C-r>f",
          open_lazy_root_live_grep = "<C-r>g",
          change_cwd_to_plugin = "<C-c>d",
        },
        actions_opts = {
          open_in_browser = {
            auto_close = false,
          },
          change_cwd_to_plugin = {
            auto_close = false,
          },
        },
        terminal_opts = {
          relative = "editor",
          style = "minimal",
          border = "rounded",
          title = "Telescope lazy",
          title_pos = "center",
          width = 0.5,
          height = 0.5,
        },
      },
    },
  },
  config = function(_, opts)
    local _, telescope = pcall(require, "telescope")
    telescope.setup(opts)
    telescope.load_extension("lazy")
  end,
}
