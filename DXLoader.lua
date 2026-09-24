-- DXLoader.lua
-- วางเป็น LocalScript ใน StarterPlayer > StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CLIENT_URL =
	"https://raw.githubusercontent.com/AomsinS4/DXPanel/refs/heads/main/DXClient.lua"

local REMOTE_NAME = "DXR_7f29A"

-- รอให้ DXServer สร้าง RemoteEvent
local remote = ReplicatedStorage:WaitForChild(REMOTE_NAME, 15)

if not remote then
	warn("[DXLoader] DXServer ไม่พร้อมใช้งาน")
	warn("[DXLoader] ตรวจสอบว่า DXServer อยู่ใน ServerScriptService")
	return
end

print("[DXLoader] DXServer connected")

-- ดาวน์โหลด DXClient
local ok, source = pcall(function()
	return game:HttpGet(CLIENT_URL)
end)

if not ok then
	warn("[DXLoader] ดาวน์โหลด DXClient ไม่สำเร็จ:")
	warn(source)
	return
end

if typeof(source) ~= "string" or #source < 100 then
	warn("[DXLoader] DXClient.lua ว่างหรือไม่ถูกต้อง")
	return
end

-- Compile
local fn, compileError = loadstring(source)

if not fn then
	warn("[DXLoader] Compile error:")
	warn(compileError)
	return
end

-- Execute
local success, runtimeError = pcall(fn)

if not success then
	warn("[DXLoader] Runtime error:")
	warn(runtimeError)
	return
end

print("[DXLoader] DXPanel loaded successfully")
