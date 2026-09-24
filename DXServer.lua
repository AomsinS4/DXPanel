-- DXServer.lua
-- Place this Script inside ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTE_NAME = "DXR_7f29A"

-- Create RemoteEvent automatically
local remote = ReplicatedStorage:FindFirstChild(REMOTE_NAME)

if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = REMOTE_NAME
	remote.Parent = ReplicatedStorage
end

local DEFAULTS = {
	WalkSpeed = 16,
	JumpPower = 50,
}

local LIMITS = {
	W = {16, 150},
	J = {50, 250},
}

local state = {}
local lastCall = {}

local MIN_INTERVAL = 0.04

local function getState(player)
	local s = state[player]

	if not s then
		s = {
			WalkSpeed = DEFAULTS.WalkSpeed,
			JumpPower = DEFAULTS.JumpPower,
		}

		state[player] = s
	end

	return s
end

local function apply(player)
	local character = player.Character

	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	local s = getState(player)

	humanoid.WalkSpeed = s.WalkSpeed
	humanoid.UseJumpPower = true
	humanoid.JumpPower = s.JumpPower
end

local function validNumber(value)
	return typeof(value) == "number"
		and value == value
		and value < math.huge
		and value > -math.huge
end

local function within(action, value)
	if not validNumber(value) then
		return false
	end

	local limit = LIMITS[action]

	if not limit then
		return false
	end

	return value >= limit[1] and value <= limit[2]
end

remote.OnServerEvent:Connect(function(player, action, value)
	if typeof(action) ~= "string" then
		return
	end

	-- Simple rate limit
	local now = os.clock()

	if now - (lastCall[player] or 0) < MIN_INTERVAL then
		return
	end

	lastCall[player] = now

	local s = getState(player)

	-- WalkSpeed
	if action == "W" then
		if not within("W", value) then
			return
		end

		s.WalkSpeed = math.floor(value + 0.5)

		apply(player)

	-- JumpPower
	elseif action == "J" then
		if not within("J", value) then
			return
		end

		s.JumpPower = math.floor(value + 0.5)

		apply(player)

	-- Reset
	elseif action == "R" then
		s.WalkSpeed = DEFAULTS.WalkSpeed
		s.JumpPower = DEFAULTS.JumpPower

		apply(player)
	end
end)

local function setupCharacter(player, character)
	character:WaitForChild("Humanoid", 5)

	task.defer(function()
		apply(player)
	end)
end

local function setupPlayer(player)
	getState(player)

	player.CharacterAdded:Connect(function(character)
		setupCharacter(player, character)
	end)

	if player.Character then
		setupCharacter(player, player.Character)
	end
end

Players.PlayerAdded:Connect(setupPlayer)

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerRemoving:Connect(function(player)
	state[player] = nil
	lastCall[player] = nil
end)
