local URL = "https://raw.githubusercontent.com/AomsinS4/DXPanel/refs/heads/main/DXClient.lua"

local ok, source = pcall(function()
	return game:HttpGet(URL)
end)

if not ok then
	warn("DXClient download failed:", source)
	return
end

local fn, err = loadstring(source)

if not fn then
	warn("DXClient compile failed:", err)
	return
end

local success, result = pcall(fn)

if not success then
	warn("DXClient error:", result)
end
