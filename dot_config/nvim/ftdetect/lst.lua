vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.lst",
  callback = function()
    vim.bo.filetype = "lst"
    vim.bo.commentstring = "# %s"
    vim.bo.syntax = "shell"
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = ".lst",
    --   callback = function()
    --     vim.cmd([[
    --       match Comment "^#.*"
    --       match @character "^[^#].*"
    --     ]])
    --   end,
    -- })
  end,
})
