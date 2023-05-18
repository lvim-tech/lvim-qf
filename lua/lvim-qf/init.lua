local config = require("lvim-qf.config")
local nav = require("lvim-qf.nav")
local menu = require("lvim-qf.menu")

local M = {}

M.setup = function(user_config)
	if user_config ~= nil then
		config = vim.tbl_deep_extend("force", config, user_config)
	end
	M.commands()
end

M.commands = function()
	vim.api.nvim_create_user_command("LvimListQuickFixNext", function()
		nav.quick_fix_next()
	end, {})
	vim.api.nvim_create_user_command("LvimListQuickFixPrev", function()
		nav.quick_fix_prev()
	end, {})
	vim.api.nvim_create_user_command("LvimListLocNext", function()
		nav.lock_next()
	end, {})
	vim.api.nvim_create_user_command("LvimListLocPrev", function()
		nav.lock_prev()
	end, {})
	vim.api.nvim_create_user_command("LvimListQuickFixMenuChoice", function()
		menu.quick_fix_menu_choice()
	end, {})
	vim.api.nvim_create_user_command("LvimListLocMenuChoice", function()
		menu.loc_menu_choice()
	end, {})
	vim.api.nvim_create_user_command("LvimListQuickFixMenuDelete", function()
		menu.quick_fix_menu_delete()
	end, {})
	vim.api.nvim_create_user_command("LvimListLocMenuDelete", function()
		menu.loc_menu_delete()
	end, {})
end
return M
