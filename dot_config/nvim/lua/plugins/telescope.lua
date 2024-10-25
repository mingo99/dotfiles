local action_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "tsakirist/telescope-lazy.nvim" },
  },
  keys = {
    { "<leader>sp", "<cmd>Telescope lazy<cr>", desc = "plugins list" },
    { "<leader>/", "<cmd>Telescope live_grep_args<CR>", desc = "Grep with args" },
    { "<leader>ga", "<cmd>Telescope git_stash<CR>", desc = "Git Stash" },
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
        "--trim",
        "--glob",
        "!{**/.git/*,**/node_modules/*,**/pkg/mod/*,**/yarn.lock,**/.local/*}",
      },
      mappings = {
        n = {
          ["<m-p>"] = action_layout.toggle_preview,
        },
        i = {
          ["<c-u>"] = false,
          ["<m-p>"] = action_layout.toggle_preview,
          ["<esc>"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        mappings = {
          i = {
            ["<c-space>"] = actions.to_fuzzy_refine,
          },
        },
      },
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
  },
  config = function(_, opts)
    local _, telescope = pcall(require, "telescope")
    opts.extensions = {
      lazy = {
        -- optional theme (the extension doesn't set a default theme)
        -- theme = "dropdown",
        -- the below configuration options are the defaults
        show_icon = true,
        mappings = {
          open_in_browser = "<c-o>",
          open_in_file_browser = "<m-b>",
          open_in_find_files = "<c-f>",
          open_in_live_grep = "<c-g>",
          open_in_terminal = "<c-t>",
          open_plugins_picker = "<c-b>",
          open_lazy_root_find_files = "<c-r>f",
          open_lazy_root_live_grep = "<c-r>g",
          change_cwd_to_plugin = "<c-c>d",
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
          title = "telescope lazy",
          title_pos = "center",
          width = 0.5,
          height = 0.5,
        },
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ["<c-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
            ["<c-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
    }

    telescope.setup(opts)
    telescope.load_extension("live_grep_args")
    telescope.load_extension("lazy")
  end,
}
