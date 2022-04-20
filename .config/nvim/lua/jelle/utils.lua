local log = require 'vim.lsp.log'

local M = {}

local function find_tab(uri)
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local wins = vim.api.nvim_tabpage_list_wins(tab)
		for _, win in ipairs(wins) do
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.uri_from_bufnr(buf) == uri then
				return tab
			end
		end
	end
end

local function get_tab(result)
	local uri = result.uri or result.targetUri
	local tab = find_tab(uri)
	if tab ~= nil then
		vim.api.nvim_set_current_tabpage(tab)
		return true
	end
end

function M.bring_or_create()
	local params = vim.lsp.util.make_position_params()

	vim.lsp.buf_request(0, "textDocument/definition", params, function (err, result, ctx, config)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, 'No location found')
			return nil
		end
		if vim.tbl_islist(result) then
			if get_tab(result[1]) then
			    	vim.lsp.util.jump_to_location(result[1], client.offset_encoding)
				return
			end
			-- else we fallback
			--
			vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
		else
			if get_tab(result) then
			    	vim.lsp.util.jump_to_location(result, client.offset_encoding)
				return
			end
			-- else we fallback
			--
			vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
		end
	end)
end

return M
