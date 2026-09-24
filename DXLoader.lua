local URL = "https://raw.githubusercontent.com/AomsinS4/DXPanel/main/DXClient.lua"

local ok, source = pcall(function()
	return game:HttpGet(URL)
end)

if not ok then
	warn("DXPanel download failed:", source)
	return
end

local fn, err = loadstring(source)

if not fn then
	warn("DXPanel compile failed:", err)
	return
end

local success, result = pcall(fn)

if not success then
	warn("DXPanel execution failed:", result)
end
