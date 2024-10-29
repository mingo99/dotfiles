vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.lst",
  callback = function()
    vim.bo.filetype = "lst"
    vim.bo.commentstring = "# %s"
  end,
})
