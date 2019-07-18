local cURL = require "cURL"
local csv = require "csv"

local listfile_url = "https://wow.tools/casc/listfile/download/csv/unverified"

local function HTTP_GET(url, file)
	local data, idx = {}, 0
	cURL.easy{
		url = url,
		writefunction = file or function(str)
			idx = idx + 1
			data[idx] = str
		end,
		ssl_verifypeer = false,
	}:perform():close()
	return table.concat(data)
end

function GetListfile(func, force)
	-- cache listfile
	local path = string.format("input/listfile.csv")
	local file = io.open(path, "r")
	if force or not file then
		file = io.open(path, "w")
		HTTP_GET(listfile_url, file) 
		file:close()
	end
	-- read listfile
	local file = csv.open(path, {separator = ";"})
	func(file)
end
