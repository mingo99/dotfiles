return {
  -- Python
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        options = {
          activate_venv_in_terminal = true,
          notify_user_on_venv_activation = true,
        },
        search = {
          venv = {
            command = "fd 'python$' -E '*lib*' -E '*init*' $HOME/.venvs",
          },
        },
      },
    },
  },
  --csv
  {
    "chrisbra/csv.vim"
  }
}
