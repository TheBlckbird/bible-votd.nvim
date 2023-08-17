local curl = require("plenary.curl")
local json = require("json.json")

local function create_readonly_buffer(contents)
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(contents, "\n"))

	vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
	vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })

	return bufnr
end

local function calculate_centered_position(width, height)
	local screen_width = vim.api.nvim_win_get_width(0)
	local screen_height = vim.api.nvim_win_get_height(0)

	local row = math.floor((screen_height - height) / 2)
	local col = math.floor((screen_width - width) / 2)

	return row, col
end

local M = {}

function M.show_votd()
	M.show_verse_of_the_day()
	return M
end

function M.show_verse_of_the_day()
	local response = curl.request({
		url = "https://beta.ourmanna.com/api/v1/get?format=json&order=daily",
		method = "get",
		accept = "application/json",
	})

	if response.status == 200 then
		local response_table = json.decode(response.body)
		local verse = response_table["verse"]["details"]["text"]
		local bible_passage = response_table["verse"]["details"]["reference"]

		local width = 80
		local height = 4

		local row, col = calculate_centered_position(width, height)

		vim.api.nvim_open_win(create_readonly_buffer(verse .. "\n– " .. bible_passage), true, {
			relative = "editor",
			row = row,
			col = col,
			width = width,
			height = height,
			border = "rounded",
			style = "minimal",
		})
	end

	return M
end

return M

-- local buf = vim.api.nvim_create_buf(false, true)
--
-- vim.api.nvim_open_win(0, true, {
-- 	relative = "win",
-- 	row = 3,
-- 	col = 3,
-- 	width = 20,
-- 	height = 20,
-- })
