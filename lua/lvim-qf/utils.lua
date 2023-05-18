local M = {}

M.table_length = function(tbl)
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

M.length = function(list)
	if list == "quick_fix" then
		return vim.fn.getqflist({ nr = "$" })["nr"]
	elseif list == "loc" then
		return vim.fn.getloclist(0, { nr = "$" })["nr"]
	end
end

M.current = function(list)
	if list == "quick_fix" then
		return vim.fn.getqflist({ nr = 0 })["nr"]
	elseif list == "loc" then
		return vim.fn.getloclist(0, { nr = 0 })["nr"]
	end
end

M.title = function(list, id)
	if list == "quick_fix" then
		return vim.fn.getqflist({ nr = id, all = 1 })["title"]
	elseif list == "loc" then
		return vim.fn.getloclist(0, { nr = id, all = 1 })["title"]
	end
end

M.list_fix = function(list)
	for i, d in ipairs(list.items) do
		if vim.api.nvim_buf_is_valid(d.bufnr) then
			d.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(d.bufnr), ":p")
		end
		d.bufnr = nil
		d.nr = nil
		list.items[i] = d
	end
	list.qfbufnr = nil
	list.winid = nil
	list.changedtick = nil
	list.context = nil
	list.id = nil
	list.idx = nil
	list.nr = nil
	list.quickfixtextfunc = nil
	list.size = nil
	return list
end

M.list_to_json = function(list, id)
	local list_content
	if list == "quick_fix" then
		list_content = vim.fn.getqflist({ nr = id, all = 1 })
	elseif list == "loc" then
		list_content = vim.fn.getloclist(0, { nr = id, all = 1 })
	end
	return M.list_fix(list_content)
end

return M
