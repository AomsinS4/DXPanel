local URL = "https://raw.githubusercontent.com/AomsinS4/DXPanel/refs/heads/main/DXLoader.lua"

local ok, source = pcall(function()
	return game:HttpGet(URL)
end)

print("DOWNLOAD:", ok)
print("SOURCE LENGTH:", typeof(source) == "string" and #source or source)

if not ok then
	warn("DOWNLOAD ERROR:", source)
	return
end

local fn, err = loadstring(source)

print("COMPILE:", fn ~= nil)

if not fn then
	warn("COMPILE ERROR:", err)
	return
end

local success, result = pcall(fn)

print("EXECUTE:", success)

if not success then
	warn("RUNTIME ERROR:", result)
end
