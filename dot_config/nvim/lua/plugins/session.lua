local function pre_save()
	-- remove buffers whose files are located outside of cwd
	local cwd = vim.fn.getcwd() .. '/'
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local bufpath = vim.api.nvim_buf_get_name(buf) .. '/'
		if not bufpath:match('^' .. vim.pesc(cwd)) then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

return {
  "folke/persistence.nvim",
  event = "ExitPre",
  opts = {
    pre_save = pre_save,
  }
}
