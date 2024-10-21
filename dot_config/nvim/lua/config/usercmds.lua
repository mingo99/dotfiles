-- show cwd in notification
vim.api.nvim_create_user_command("ShowCwd", function()
  vim.notify("Current working directory: " .. vim.fn.getcwd())
end, { nargs = 0 })
-- show root dir in notification
vim.api.nvim_create_user_command("ShowRootDir", function()
  vim.notify("Project Root directory: " .. vim.fn.systemlist("git rev-parse --show-toplevel")[1])
end, { nargs = 0 })
