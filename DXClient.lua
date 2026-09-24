-- DX Panel + DX.txt features
-- Single LocalScript: StarterPlayer > StarterPlayerScripts
-- GUI layout/style follows the supplied DX Panel. Feature logic is integrated below.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Small client-side obfuscation layer. This is NOT encryption.
local function _dxs(...)
    local t = table.pack(...)
    local out = table.create(t.n)
    for i = 1, t.n do
        out[i] = string.char(t[i])
    end
    return table.concat(out)
end

local _DX_REMOTE_NAME = _dxs(68,88,82,95,55,102,50,57,65)
local _DX_REMOTE = ReplicatedStorage:WaitForChild(_DX_REMOTE_NAME)

local function _dxSend(action, value)
    _DX_REMOTE:FireServer(action, value)
end

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    camera = workspace.CurrentCamera
end)

-- =========================================================
-- DX.txt CONFIG / STATE
-- =========================================================
local Config = {
	AimAssist = true,
	AimStrength = 75,
	MinStrength = 5,
	MaxStrength = 100,
	MaxDistance = 500,
	MinDistance = 50,
	MaxDistanceLimit = 1500,
	FovRadius = 180,
	MinFov = 10,
	MaxFov = 400,
	ShowFov = true,
	TargetPart = "Head",

	PlayerESP = true,
	EspBox = true,
	EspHealthBar = true,
	EspDistance = true,
	EspLine = true,
	TeamCheck = true,

	WalkSpeed = 16,
	DefaultWalkSpeed = 16,
	JumpPower = 50,
	DefaultJumpPower = 50,
	InfiniteJump = false,
	FieldOfView = 70,
	DefaultFieldOfView = 70,
	FullBright = false,

	GuiLocked = false,
	ShowPerformanceOverlay = true,
}

local State = {
	CurrentTarget = nil,
	ESP = {},
	OriginalLighting = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogEnd = Lighting.FogEnd,
		GlobalShadows = Lighting.GlobalShadows,
	},
}

-- =========================================================
-- ORIGINAL DX GUI
-- =========================================================
local gui = Instance.new("ScreenGui")
gui.Name = "DXGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local C = {
	bg = Color3.fromRGB(8, 8, 11),
	side = Color3.fromRGB(14, 14, 18),
	row = Color3.fromRGB(22, 22, 28),
	accent = Color3.fromRGB(255, 25, 60),
	accent2 = Color3.fromRGB(110, 0, 25),
	off = Color3.fromRGB(50, 50, 58),
	text = Color3.fromRGB(245, 245, 250),
	sub = Color3.fromRGB(140, 140, 150),
	online = Color3.fromRGB(60, 255, 120),
	yellow = Color3.fromRGB(241, 196, 15),
}

local neonSeq = ColorSequence.new({
	ColorSequenceKeypoint.new(0, C.accent),
	ColorSequenceKeypoint.new(0.5, C.accent2),
	ColorSequenceKeypoint.new(1, C.accent),
})

local function make(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

local function round(o, r)
	make("UICorner", {CornerRadius = UDim.new(0, r or 8)}, o)
end

local function addGlow(parent, radius, layers)
	local list = {}
	for _, l in ipairs(layers) do
		local f = make("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, l.grow, 1, l.grow),
			BackgroundTransparency = 1,
			ZIndex = 0,
		}, parent)
		round(f, radius + l.grow / 2)
		local s = make("UIStroke", {
			Color = C.accent,
			Thickness = l.thick,
			Transparency = l.trans,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}, f)
		table.insert(list, {stroke = s, trans = l.trans})
	end
	return list
end

local function draggable(handle, target, onClick)
	local dragging, active, startMouse, startPos, moved = false, nil, nil, nil, 0

	local function isPointer(input)
		return input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
	end

	handle.InputBegan:Connect(function(input)
		if dragging or not isPointer(input) or Config.GuiLocked then return end
		dragging = true
		active = input
		startMouse = input.Position
		startPos = target.Position
		moved = 0
	end)

	UIS.InputChanged:Connect(function(input)
		if not dragging then return end
		local mine = (input == active)
			or (active.UserInputType == Enum.UserInputType.MouseButton1
				and input.UserInputType == Enum.UserInputType.MouseMovement)
		if not mine then return end
		local dx = input.Position.X - startMouse.X
		local dy = input.Position.Y - startMouse.Y
		moved = math.max(moved, math.sqrt(dx * dx + dy * dy))
		target.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + dx,
			startPos.Y.Scale, startPos.Y.Offset + dy
		)
	end)

	UIS.InputEnded:Connect(function(input)
		if not dragging then return end
		local mine = (input == active)
			or (active.UserInputType == Enum.UserInputType.MouseButton1
				and input.UserInputType == Enum.UserInputType.MouseButton1)
		if not mine then return end
		dragging = false
		active = nil
		if onClick and moved < 6 then onClick() end
	end)
end

local vp = camera.ViewportSize
local W = math.clamp(vp.X * 0.85, 300, 520)
local H = math.clamp(vp.Y * 0.75, 240, 340)
local sideW = W < 400 and 90 or 120

local root = make("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Size = UDim2.fromOffset(W, H),
	Position = UDim2.fromScale(0.5, 0.5),
	BackgroundTransparency = 1,
}, gui)
local scale = make("UIScale", {Scale = 1}, root)

local glows = addGlow(root, 14, {
	{grow = 14, thick = 7, trans = 0.88},
	{grow = 6, thick = 4, trans = 0.7},
})

local window = make("CanvasGroup", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = C.bg,
	GroupTransparency = 0,
	ZIndex = 1,
}, root)
round(window, 14)

local stroke = make("UIStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 2,
	Transparency = 0,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, window)
local strokeGrad = make("UIGradient", {Color = neonSeq}, stroke)

local title = make("Frame", {
	Size = UDim2.new(1, 0, 0, 40),
	BackgroundColor3 = C.side,
	BorderSizePixel = 0,
}, window)

make("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 1, -1),
	BackgroundColor3 = C.accent,
	BackgroundTransparency = 0.3,
	BorderSizePixel = 0,
}, title)

local titleLbl = make("TextLabel", {
	Size = UDim2.new(0, 90, 1, 0),
	Position = UDim2.fromOffset(16, 0),
	BackgroundTransparency = 1,
	Text = "DX Panel",
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamBlack,
	TextSize = 15,
	TextColor3 = C.text,
}, title)

make("UIStroke", {
	Color = C.accent,
	Thickness = 1.2,
	Transparency = 0.45,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
}, titleLbl)

local closeBtn = make("TextButton", {
	Size = UDim2.fromOffset(26, 26),
	Position = UDim2.new(1, -36, 0.5, -13),
	BackgroundColor3 = C.accent,
	Text = "",
	AutoButtonColor = false,
}, title)
round(closeBtn, 13)

for _, rot in ipairs({45, -45}) do
	local bar = make("Frame", {
		Size = UDim2.fromOffset(14, 2),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Rotation = rot,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
	}, closeBtn)
	round(bar, 1)
end

closeBtn.MouseEnter:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(255, 90, 110)
	}):Play()
end)
closeBtn.MouseLeave:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.15), {
		BackgroundColor3 = C.accent
	}):Play()
end)

local userBox = make("Frame", {
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -46, 0, 0),
	Size = UDim2.new(0, 120, 1, 0),
	BackgroundTransparency = 1,
}, title)

make("TextLabel", {
	Position = UDim2.fromOffset(0, 4),
	Size = UDim2.new(1, 0, 0, 17),
	BackgroundTransparency = 1,
	Text = player.DisplayName,
	TextXAlignment = Enum.TextXAlignment.Right,
	TextTruncate = Enum.TextTruncate.AtEnd,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = C.text,
}, userBox)

local statusRow = make("Frame", {
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 21),
	Size = UDim2.new(0, 0, 0, 14),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
}, userBox)

make("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 4),
	VerticalAlignment = Enum.VerticalAlignment.Center,
	HorizontalAlignment = Enum.HorizontalAlignment.Left,
}, statusRow)

local dot = make("Frame", {
	Size = UDim2.fromOffset(7, 7),
	BackgroundColor3 = C.online,
	LayoutOrder = 1,
}, statusRow)
round(dot, 4)

make("UIStroke", {
	Color = C.online,
	Thickness = 2,
	Transparency = 0.6,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, dot)

make("TextLabel", {
	Size = UDim2.new(0, 0, 1, 0),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
	Text = "Online",
	LayoutOrder = 2,
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextColor3 = C.online,
}, statusRow)

draggable(title, root)

local side = make("Frame", {
	Size = UDim2.new(0, sideW, 1, -40),
	Position = UDim2.fromOffset(0, 40),
	BackgroundColor3 = C.side,
	BorderSizePixel = 0,
}, window)

make("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, side)

make("UIPadding", {
	PaddingTop = UDim.new(0, 10),
	PaddingLeft = UDim.new(0, 8),
	PaddingRight = UDim.new(0, 8),
}, side)

local content = make("Frame", {
	Size = UDim2.new(1, -sideW, 1, -40),
	Position = UDim2.fromOffset(sideW, 40),
	BackgroundTransparency = 1,
}, window)

local tabs = {}

local function selectTab(name)
	for n, t in pairs(tabs) do
		local on = (n == name)
		t.page.Visible = on
		TweenService:Create(t.btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			BackgroundColor3 = on and C.accent or C.row,
			TextColor3 = on and Color3.new(1, 1, 1) or C.sub,
		}):Play()
		TweenService:Create(t.stroke, TweenInfo.new(0.2), {
			Transparency = on and 0.1 or 0.85
		}):Play()
	end
end

local function addTab(name)
	local btn = make("TextButton", {
		Size = UDim2.new(1, 0, 0, 32),
		BackgroundColor3 = C.row,
		Text = name,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.sub,
		AutoButtonColor = false,
	}, side)
	round(btn, 8)

	local bs = make("UIStroke", {
		Color = C.accent,
		Thickness = 1,
		Transparency = 0.85,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, btn)

	local page = make("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = C.accent,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		Visible = false,
	}, content)

	make("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, page)

	make("UIPadding", {
		PaddingTop = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
	}, page)

	tabs[name] = {btn = btn, page = page, stroke = bs}
	btn.MouseButton1Click:Connect(function() selectTab(name) end)

	return page
end

local function row(page, h)
	local r = make("Frame", {
		Size = UDim2.new(1, 0, 0, h or 36),
		BackgroundColor3 = C.row,
	}, page)
	round(r, 8)

	make("UIStroke", {
		Color = C.accent,
		Thickness = 1,
		Transparency = 0.82,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, r)

	return r
end

local function label(parent, text, w)
	return make("TextLabel", {
		Size = UDim2.new(w or 1, -12, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = C.text,
	}, parent)
end

local function addSection(page, text)
	make("TextLabel", {
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = C.accent,
	}, page)
end

local function addButton(page, text, cb)
	local r = row(page)
	local b = make("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = C.text,
	}, r)

	b.MouseButton1Click:Connect(function()
		TweenService:Create(r, TweenInfo.new(0.08), {
			BackgroundColor3 = C.accent
		}):Play()
		task.delay(0.1, function()
			if r.Parent then
				TweenService:Create(r, TweenInfo.new(0.25), {
					BackgroundColor3 = C.row
				}):Play()
			end
		end)
		if cb then cb() end
	end)

	return b
end

local function addToggle(page, text, default, cb)
	local r = row(page)
	label(r, text, 0.7)

	local state = default
	local pill = make("TextButton", {
		Size = UDim2.fromOffset(40, 20),
		Position = UDim2.new(1, -52, 0.5, -10),
		BackgroundColor3 = state and C.accent or C.off,
		Text = "",
		AutoButtonColor = false,
	}, r)
	round(pill, 10)

	local ps = make("UIStroke", {
		Color = C.accent,
		Thickness = 3,
		Transparency = state and 0.6 or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, pill)

	local knob = make("Frame", {
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Position = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2),
	}, pill)
	round(knob, 8)

	pill.MouseButton1Click:Connect(function()
		state = not state
		local info = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		TweenService:Create(pill, info, {
			BackgroundColor3 = state and C.accent or C.off
		}):Play()
		TweenService:Create(ps, info, {
			Transparency = state and 0.6 or 1
		}):Play()
		TweenService:Create(knob, info, {
			Position = state and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
		}):Play()
		if cb then cb(state) end
	end)
end

local function addSlider(page, text, min, max, default, cb, suffix)
	local r = row(page, 50)
	local lbl = label(r, text .. ": " .. tostring(default) .. (suffix or ""))
	lbl.Size = UDim2.new(1, -12, 0, 26)

	local bar = make("Frame", {
		Size = UDim2.new(1, -24, 0, 6),
		Position = UDim2.new(0, 12, 0, 34),
		BackgroundColor3 = C.off,
	}, r)
	round(bar, 3)

	local fill = make("Frame", {
		Size = UDim2.fromScale((default - min) / (max - min), 1),
		BackgroundColor3 = C.accent,
	}, bar)
	round(fill, 3)

	make("UIStroke", {
		Color = C.accent,
		Thickness = 3,
		Transparency = 0.65,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, fill)

	make("UIGradient", {
		Color = ColorSequence.new(C.accent2, C.accent)
	}, fill)

	local active = nil

	local function update(x)
		local a = math.clamp(
			(x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1),
			0, 1
		)
		local v = math.floor(min + (max - min) * a + 0.5)
		fill.Size = UDim2.fromScale(a, 1)
		lbl.Text = text .. ": " .. tostring(v) .. (suffix or "")
		if cb then cb(v) end
	end

	r.InputBegan:Connect(function(i)
		if active then return end
		if i.UserInputType == Enum.UserInputType.MouseButton1
			or i.UserInputType == Enum.UserInputType.Touch then
			active = i
			update(i.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if not active then return end
		if i == active
			or (active.UserInputType == Enum.UserInputType.MouseButton1
				and i.UserInputType == Enum.UserInputType.MouseMovement) then
			update(i.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if not active then return end
		if i == active
			or (active.UserInputType == Enum.UserInputType.MouseButton1
				and i.UserInputType == Enum.UserInputType.MouseButton1) then
			active = nil
		end
	end)
end

-- =========================================================
-- OVERVIEW - kept in the same DX style
-- =========================================================
local overview = addTab("Overview")
local spin = {model = nil, angle = 0}

addSection(overview, "CHARACTER")

do
	local card = row(overview, 180)

	local vf = make("ViewportFrame", {
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.new(0.5, -12, 1, -16),
		BackgroundColor3 = C.bg,
		BorderSizePixel = 0,
		Ambient = Color3.fromRGB(170, 170, 180),
		LightColor = Color3.fromRGB(255, 255, 255),
		LightDirection = Vector3.new(-1, -1, 1),
	}, card)
	round(vf, 8)

	make("UIStroke", {
		Color = C.accent,
		Thickness = 1,
		Transparency = 0.6,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, vf)

	local cam = make("Camera", {FieldOfView = 35}, vf)
	cam.CFrame = CFrame.new(Vector3.new(0, 0.3, -10), Vector3.new(0, -0.2, 0))
	vf.CurrentCamera = cam

	make("TextLabel", {
		Position = UDim2.new(0.5, 4, 0, 8),
		Size = UDim2.new(0.5, -12, 1, -82),
		BackgroundTransparency = 1,
		RichText = true,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = C.sub,
		Text = string.format(
			'<font color="#F5F5FA" size="14"><b>%s</b></font>\n@%s\nID: %d',
			player.DisplayName, player.Name, player.UserId
		),
	}, card)

	local srv = make("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0.5, 4, 1, -8),
		Size = UDim2.new(0.5, -12, 0, 58),
		BackgroundTransparency = 1,
	}, card)

	make("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = C.accent,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
	}, srv)

	make("TextLabel", {
		Position = UDim2.fromOffset(0, 8),
		Size = UDim2.new(0.5, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = "Players",
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = C.sub,
	}, srv)

	local val = make("TextLabel", {
		Position = UDim2.new(0.5, 0, 0, 8),
		Size = UDim2.new(0.5, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = "0 / 0",
		TextXAlignment = Enum.TextXAlignment.Right,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = C.accent,
	}, srv)

	local bar = make("Frame", {
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = C.off,
	}, srv)
	round(bar, 3)

	local fill = make("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = C.accent,
	}, bar)
	round(fill, 3)

	local function refresh()
		local n = #Players:GetPlayers()
		local m = math.max(Players.MaxPlayers, 1)
		val.Text = n .. " / " .. m
		TweenService:Create(fill, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
			Size = UDim2.fromScale(math.clamp(n / m, 0, 1), 1),
		}):Play()
	end

	refresh()
	Players.PlayerAdded:Connect(function() task.defer(refresh) end)
	Players.PlayerRemoving:Connect(function() task.delay(0.2, refresh) end)

	local function clearModels()
		for _, c in ipairs(vf:GetChildren()) do
			if c:IsA("Model") then c:Destroy() end
		end
		spin.model = nil
	end

	local function setup(char)
		clearModels()
		if not char then return end

		local hrp = char:WaitForChild("HumanoidRootPart", 5)
		if not hrp then return end

		local old = char.Archivable
		char.Archivable = true
		local clone = char:Clone()
		char.Archivable = old
		if not clone then return end

		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("BaseScript") or d:IsA("Sound") then
				d:Destroy()
			elseif d:IsA("BasePart") then
				d.Anchored = true
			end
		end

		local hum = clone:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end

		clone.Parent = vf
		clone:PivotTo(CFrame.new())
		spin.model = clone
	end

	task.spawn(function()
		setup(player.Character or player.CharacterAdded:Wait())
	end)

	player.CharacterAdded:Connect(function(char)
		task.spawn(setup, char)
	end)
end

-- =========================================================
-- COMBAT TAB - DX.txt functionality
-- =========================================================
local combat = addTab("Combat")

addSection(combat, "AIM ASSIST")

addToggle(combat, "Enable Aim Assist", Config.AimAssist, function(v)
	Config.AimAssist = v
	if not v then State.CurrentTarget = nil end
end)

addSlider(combat, "Aim Strength", Config.MinStrength, Config.MaxStrength, Config.AimStrength,
	function(v) Config.AimStrength = v end, "%")

addSlider(combat, "Max Distance", Config.MinDistance, Config.MaxDistanceLimit, Config.MaxDistance,
	function(v) Config.MaxDistance = v end, " STUD")

addSlider(combat, "FOV Radius", Config.MinFov, Config.MaxFov, Config.FovRadius,
	function(v) Config.FovRadius = v end, " PX")

addSection(combat, "TARGETING")

addToggle(combat, "Show FOV Circle", Config.ShowFov, function(v)
	Config.ShowFov = v
end)

addToggle(combat, "Team Check", Config.TeamCheck, function(v)
	Config.TeamCheck = v
end)

local boneNames = {"Head", "Torso", "Random"}
local boneIndex = 1

local boneButton
boneButton = addButton(combat, "Target Bone: " .. Config.TargetPart, function()
	boneIndex = (boneIndex % #boneNames) + 1
	Config.TargetPart = boneNames[boneIndex]
	boneButton.Text = "Target Bone: " .. Config.TargetPart
end)

-- =========================================================
-- VISUALS TAB - DX.txt functionality
-- =========================================================
local visuals = addTab("Visuals")

addSection(visuals, "ESP OVERLAY")

addToggle(visuals, "Enable Player ESP", Config.PlayerESP, function(v)
	Config.PlayerESP = v
	if not v then
		for char in pairs(State.ESP) do
			State.ESP[char]:Destroy()
			State.ESP[char] = nil
		end
	end
end)

addToggle(visuals, "Bounding Box", Config.EspBox, function(v)
	Config.EspBox = v
end)

addToggle(visuals, "Health Bar", Config.EspHealthBar, function(v)
	Config.EspHealthBar = v
end)

addToggle(visuals, "Distance Tags", Config.EspDistance, function(v)
	Config.EspDistance = v
end)

addToggle(visuals, "Enemy Tracer Line", Config.EspLine, function(v)
	Config.EspLine = v
end)

addSection(visuals, "VISUAL FILTERS")

addToggle(visuals, "Enemy Only / Team Check", Config.TeamCheck, function(v)
	Config.TeamCheck = v
end)

-- =========================================================
-- PLAYER TAB - DX.txt functionality
-- =========================================================
local main = addTab("Main")

addSection(main, "MOVEMENT")

addSlider(main, "Walk Speed", 16, 150, Config.WalkSpeed,
	function(v)
		Config.WalkSpeed = v
		_dxSend("W", v)
	end)

addSlider(main, "Jump Power", 50, 250, Config.JumpPower,
	function(v)
		Config.JumpPower = v
		_dxSend("J", v)
	end)

addToggle(main, "Infinite Jump", Config.InfiniteJump, function(v)
	Config.InfiniteJump = v
end)

addSection(main, "WORLD")

addSlider(main, "Field Of View", 70, 120, Config.FieldOfView,
	function(v) Config.FieldOfView = v end)

addToggle(main, "Full Bright", Config.FullBright, function(v)
	Config.FullBright = v
end)

-- =========================================================
-- SETTINGS / CONFIGS TAB
-- =========================================================
local settings = addTab("Settings")

addSection(settings, "INTERFACE")

addToggle(settings, "Lock GUI Position", Config.GuiLocked, function(v)
	Config.GuiLocked = v
end)

addToggle(settings, "Ping & FPS Overlay", Config.ShowPerformanceOverlay, function(v)
	Config.ShowPerformanceOverlay = v
end)

addButton(settings, "Reset Defaults", function()
	Config.AimAssist = false
	Config.AimStrength = 75
	Config.MaxDistance = 500
	Config.FovRadius = 180
	Config.ShowFov = true
	Config.TargetPart = "Head"
	Config.PlayerESP = false
	Config.EspBox = true
	Config.EspHealthBar = true
	Config.EspDistance = true
	Config.EspLine = true
	Config.TeamCheck = true
	Config.WalkSpeed = 16
	Config.JumpPower = 50
	_dxSend("R")
	Config.InfiniteJump = false
	Config.FieldOfView = 70
	Config.FullBright = false
	State.CurrentTarget = nil
end)

addButton(settings, "Unload Script", function()
	for char, obj in pairs(State.ESP) do
		if obj then obj:Destroy() end
	end
	State.ESP = {}

	Lighting.Brightness = State.OriginalLighting.Brightness
	Lighting.ClockTime = State.OriginalLighting.ClockTime
	Lighting.FogEnd = State.OriginalLighting.FogEnd
	Lighting.GlobalShadows = State.OriginalLighting.GlobalShadows

	pcall(function() RunService:UnbindFromRenderStep("DX_AimAssist") end)
	if gui then gui:Destroy() end
end)

selectTab("Overview")

-- Sync initial server-authoritative movement values.
_dxSend("W", Config.WalkSpeed)
_dxSend("J", Config.JumpPower)

-- =========================================================
-- FOV CIRCLE
-- =========================================================
local fovFrame = make("Frame", {
	Name = "FovCircle",
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 5,
}, gui)
round(fovFrame, 999)

make("UIStroke", {
	Color = C.accent,
	Thickness = 1.2,
	Transparency = 0.4,
}, fovFrame)

-- =========================================================
-- TARGET HELPERS / AIM ASSIST
-- =========================================================
local function getRoot(char)
	if not char then return nil end
	return char:FindFirstChild("HumanoidRootPart")
		or char:FindFirstChild("UpperTorso")
		or char:FindFirstChild("Torso")
end

local function getHead(char)
	if not char then return nil end
	return char:FindFirstChild("Head") or getRoot(char)
end

local function getHumanoid(char)
	return char and char:FindFirstChildOfClass("Humanoid")
end

local function getHealth(char)
	local hum = getHumanoid(char)
	return hum and hum.Health or 0
end

local function getTeam(entity)
    if not entity then return nil end

    local char
    if typeof(entity) == "Instance" and entity:IsA("Model") then
        char = entity
    elseif typeof(entity) == "Instance" and entity:IsA("Player") then
        char = entity.Character
    end

    if char then
        local attr = char:GetAttribute("Team")
            or char:GetAttribute("Faction")
            or char:GetAttribute("TeamName")
        if attr ~= nil then
            return tostring(attr)
        end
    end

    local targetPlayer
    if typeof(entity) == "Instance" and entity:IsA("Player") then
        targetPlayer = entity
    elseif char then
        targetPlayer = Players:GetPlayerFromCharacter(char) or Players:FindFirstChild(char.Name)
    end

    if targetPlayer then
        local pAttr = targetPlayer:GetAttribute("Team")
            or targetPlayer:GetAttribute("TeamName")
            or targetPlayer:GetAttribute("Faction")
        if pAttr ~= nil then
            return tostring(pAttr)
        end

        if targetPlayer.Team ~= nil then
            return targetPlayer.Team.Name
        end

        if not targetPlayer.Neutral and targetPlayer.TeamColor then
            return targetPlayer.TeamColor.Name
        end
    end

    return nil
end

local function isOpponent(char)
    if not char or char == player.Character or char.Name == player.Name then
        return false
    end

    local rootPart = getRoot(char)
    if not rootPart then
        return false
    end

    if getHealth(char) <= 0 then
        return false
    end

    local myTeam = getTeam(player)
    local targetTeam = getTeam(char)

    if myTeam ~= nil and targetTeam ~= nil then
        if myTeam == "Vanguards" then
            return targetTeam == "Phantoms"
        elseif myTeam == "Phantoms" then
            return targetTeam == "Vanguards"
        else
            return myTeam ~= targetTeam
        end
    end

    return true
end
local function getEnemies()
	local result, seen = {}, {}

	local live = workspace:FindFirstChild("Live")
	if live then
		for _, char in ipairs(live:GetChildren()) do
			if char:IsA("Model") and not seen[char] and isOpponent(char) then
				seen[char] = true
				table.insert(result, char)
			end
		end
	end

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and not seen[p.Character] and isOpponent(p.Character) then
			seen[p.Character] = true
			table.insert(result, p.Character)
		end
	end

	return result
end

local function insideFov(char, multiplier)
	local head = getHead(char)
	local rootPart = getRoot(char)
	if not head and not rootPart then return false end

	local viewport = camera.ViewportSize
	local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
	local radius = Config.FovRadius * (multiplier or 1)

	for _, part in ipairs({head, rootPart}) do
		if part then
			local p, onScreen = camera:WorldToViewportPoint(part.Position)
			if onScreen and p.Z > 0 then
				local dist = (Vector2.new(p.X, p.Y) - center).Magnitude
				if dist <= radius then return true end
			end
		end
	end

	return false
end

local function hasLineOfSight(targetChar, targetPart)
    if not targetPart or not camera then return false end
    local origin = camera.CFrame.Position
    local direction = targetPart.Position - origin

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true

    local ignore = {player.Character}
    if camera then table.insert(ignore, camera) end
    params.FilterDescendantsInstances = ignore

    local hit = workspace:Raycast(origin, direction, params)
    if not hit then
        return true
    end

    return hit.Instance:IsDescendantOf(targetChar)
end

local function findBestTarget()
    local myRoot = getRoot(player.Character)
    if not myRoot then return nil end

    local bestTarget = nil
    local bestScreenDist = math.huge
    local bestWorldDist = math.huge
    local viewport = camera.ViewportSize
    local center = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5)

    for _, char in ipairs(getEnemies()) do
        local hp = getHealth(char)
        local rootPart = getRoot(char)
        local head = getHead(char)

        if hp > 0 and rootPart then
            local worldDist = (myRoot.Position - rootPart.Position).Magnitude
            if worldDist <= Config.MaxDistance then
                local candidate = head or rootPart
                local screen, onScreen = camera:WorldToViewportPoint(candidate.Position)

                if onScreen and screen.Z > 0 then
                    local screenDist = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                    if screenDist <= Config.FovRadius and hasLineOfSight(char, candidate) then
                        if screenDist < bestScreenDist
                            or (math.abs(screenDist - bestScreenDist) < 0.5 and worldDist < bestWorldDist) then
                            bestTarget = char
                            bestScreenDist = screenDist
                            bestWorldDist = worldDist
                        end
                    end
                end
            end
        end
    end

    return bestTarget
end

local randomBone = "Head"

local function updateTarget()
    if not Config.AimAssist then
        State.CurrentTarget = nil
        return
    end

    if State.CurrentTarget then
        if not isOpponent(State.CurrentTarget)
            or getHealth(State.CurrentTarget) <= 0
            or not insideFov(State.CurrentTarget, 1.25)
            or not hasLineOfSight(State.CurrentTarget, getHead(State.CurrentTarget) or getRoot(State.CurrentTarget)) then
            State.CurrentTarget = nil
        end
    end

    local nearest = findBestTarget()

    if not State.CurrentTarget then
        State.CurrentTarget = nearest
        return
    end

    if nearest and nearest ~= State.CurrentTarget then
        local myRoot = getRoot(player.Character)
        local currRoot = getRoot(State.CurrentTarget)
        local nearRoot = getRoot(nearest)

        if myRoot and currRoot and nearRoot then
            local currDist = (myRoot.Position - currRoot.Position).Magnitude
            local nearDist = (myRoot.Position - nearRoot.Position).Magnitude
            if nearDist < (currDist - 15) then
                State.CurrentTarget = nearest
            end
        else
            State.CurrentTarget = nearest
        end
    end
end

local lastAimRotation = nil
local lastAimTarget = nil
local randomBoneChoice = "Head"

local function aimStep(dt)
    if not Config.AimAssist or not State.CurrentTarget then
        lastAimRotation = nil
        lastAimTarget = nil
        return
    end

    local targetChar = State.CurrentTarget
    if not targetChar or not targetChar.Parent or not isOpponent(targetChar) then
        State.CurrentTarget = nil
        lastAimRotation = nil
        lastAimTarget = nil
        return
    end

    if not insideFov(targetChar, 1.25) then
        State.CurrentTarget = nil
        lastAimRotation = nil
        lastAimTarget = nil
        return
    end

    local targetHead = getHead(targetChar)
    local targetRoot = getRoot(targetChar)
    if not targetHead or not targetRoot then
        return
    end

    local currentCFrame = camera.CFrame
    local cameraPos = currentCFrame.Position

    if lastAimTarget ~= targetChar then
        lastAimTarget = targetChar
        lastAimRotation = currentCFrame.Rotation
        randomBoneChoice = (math.random() < 0.65) and "Head" or "Torso"
    end

    local selectedPart = targetHead
    local offset = Vector3.zero

    if Config.TargetPart == "Torso" then
        selectedPart = targetRoot
        offset = Vector3.new(0, 0.4, 0)
    elseif Config.TargetPart == "Random" then
        if randomBoneChoice == "Torso" then
            selectedPart = targetRoot
            offset = Vector3.new(0, 0.4, 0)
        else
            selectedPart = targetHead
        end
    end

    if not hasLineOfSight(targetChar, selectedPart) then
        State.CurrentTarget = nil
        lastAimRotation = nil
        lastAimTarget = nil
        return
    end

    local targetPos = selectedPart.Position + offset
    local velocity = targetRoot.AssemblyLinearVelocity or targetRoot.Velocity

    if velocity then
        local horizontalVel = Vector3.new(velocity.X, 0, velocity.Z)
        if horizontalVel.Magnitude > 2.5 then
            local distance = (targetPos - cameraPos).Magnitude
            local timeToHit = math.clamp(distance / 1500, 0, 0.12)
            targetPos = targetPos + horizontalVel * timeToHit
        end
    end

    local targetCFrame = CFrame.lookAt(cameraPos, targetPos)
    local targetRotation = targetCFrame.Rotation
    local strength = math.clamp(Config.AimStrength / 100, 0.1, 1)
    local alpha = math.clamp(strength * (dt * 60), 0.25, 1)

    if not lastAimRotation then
        lastAimRotation = currentCFrame.Rotation
    end

    lastAimRotation = lastAimRotation:Lerp(targetRotation, alpha)
    camera.CFrame = CFrame.new(cameraPos) * lastAimRotation
end

-- =========================================================
-- ESP
-- =========================================================
local espFolder = Instance.new("Folder")
espFolder.Name = "DX_ESP"
espFolder.Parent = gui

local function createESP(char)
    if State.ESP[char] then return State.ESP[char] end

    local holder = Instance.new("Folder")
    holder.Name = "ESP_" .. char.Name
    holder.Parent = espFolder

    local function edge(name)
        local f = Instance.new("Frame")
        f.Name = name
        f.BackgroundColor3 = C.accent
        f.BorderSizePixel = 0
        f.Visible = false
        f.ZIndex = 20
        f.Parent = holder
        return f
    end

    local top = edge("BoxTop")
    local bottom = edge("BoxBottom")
    local left = edge("BoxLeft")
    local right = edge("BoxRight")

    local hpBg = Instance.new("Frame")
    hpBg.Name = "HealthBG"
    hpBg.BackgroundColor3 = Color3.fromRGB(25,25,25)
    hpBg.BorderSizePixel = 0
    hpBg.Visible = false
    hpBg.ZIndex = 20
    hpBg.Parent = holder

    local hpFill = Instance.new("Frame")
    hpFill.Name = "HealthFill"
    hpFill.BackgroundColor3 = C.online
    hpFill.BorderSizePixel = 0
    hpFill.Visible = false
    hpFill.ZIndex = 21
    hpFill.Parent = hpBg

    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "Info"
    distLabel.BackgroundTransparency = 1
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextSize = 10
    distLabel.TextColor3 = Color3.new(1,1,1)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Visible = false
    distLabel.ZIndex = 22
    distLabel.Parent = holder

    local tracerGlow = Instance.new("Frame")
    tracerGlow.Name = "TracerGlow"
    tracerGlow.AnchorPoint = Vector2.new(0.5,0.5)
    tracerGlow.BackgroundColor3 = C.accent
    tracerGlow.BackgroundTransparency = 0.78
    tracerGlow.BorderSizePixel = 0
    tracerGlow.Visible = false
    tracerGlow.ZIndex = 18
    tracerGlow.Parent = holder

    local tracer = Instance.new("Frame")
    tracer.Name = "Tracer"
    tracer.AnchorPoint = Vector2.new(0.5,0.5)
    tracer.BackgroundColor3 = C.accent
    tracer.BorderSizePixel = 0
    tracer.Visible = false
    tracer.ZIndex = 19
    tracer.Parent = holder

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.3, C.accent),
        ColorSequenceKeypoint.new(1, C.accent2),
    })
    gradient.Parent = tracer

    State.ESP[char] = {
        holder=holder, top=top, bottom=bottom, left=left, right=right,
        hpBg=hpBg, hpFill=hpFill, label=distLabel,
        tracer=tracer, tracerGlow=tracerGlow
    }

    holder.Destroying:Connect(function()
        if State.ESP[char] and State.ESP[char].holder == holder then
            State.ESP[char] = nil
        end
    end)

    return State.ESP[char]
end
local function removeESP(char)
    local data = State.ESP[char]
    if data and data.holder then
        data.holder:Destroy()
    end
    State.ESP[char] = nil
end
local function setTracer(frame, fromPos, toPos, thickness)
	local delta = toPos - fromPos
	local length = delta.Magnitude
	if length < 1 then
		frame.Visible = false
		return
	end
	frame.Position = UDim2.fromOffset((fromPos.X + toPos.X) * 0.5, (fromPos.Y + toPos.Y) * 0.5)
	frame.Size = UDim2.fromOffset(length, thickness)
	frame.Rotation = math.deg(math.atan2(delta.Y, delta.X))
	frame.Visible = true
end

local function updateESP()
    if not Config.PlayerESP then
        for char in pairs(State.ESP) do removeESP(char) end
        return
    end

    local active = {}
    local viewport = camera.ViewportSize
    local screenBottom = Vector2.new(viewport.X * 0.5, viewport.Y - 14)

    for _, char in ipairs(getEnemies()) do
        local head = getHead(char)
        local rootPart = getRoot(char)
        if not head or not rootPart then continue end

        active[char] = true
        local e = createESP(char)

        local headPos, headOn = camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.35,0))
        local rootPos, rootOn = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0,2.8,0))
        local visible = headOn and rootOn and headPos.Z > 0 and rootPos.Z > 0

        if not visible then
            e.top.Visible=false; e.bottom.Visible=false; e.left.Visible=false; e.right.Visible=false
            e.hpBg.Visible=false; e.hpFill.Visible=false; e.label.Visible=false
            e.tracer.Visible=false; e.tracerGlow.Visible=false
            continue
        end

        local height = math.max(math.abs(rootPos.Y-headPos.Y), 24)
        local width = math.max(height*0.55, 24)
        local x = headPos.X-width/2
        local y = math.min(headPos.Y,rootPos.Y)
        local boxColor = State.CurrentTarget == char and C.yellow or C.accent

        -- Screen-space GUI is rendered over the 3D scene, so the box and tracer
        -- remain visible even when a wall/prop is between the camera and target.
        for _, f in ipairs({e.top,e.bottom,e.left,e.right}) do
            f.BackgroundColor3=boxColor
            f.Visible=Config.EspBox
        end
        e.top.Position=UDim2.fromOffset(x,y)
        e.top.Size=UDim2.fromOffset(width,2)
        e.bottom.Position=UDim2.fromOffset(x,y+height-2)
        e.bottom.Size=UDim2.fromOffset(width,2)
        e.left.Position=UDim2.fromOffset(x,y)
        e.left.Size=UDim2.fromOffset(2,height)
        e.right.Position=UDim2.fromOffset(x+width-2,y)
        e.right.Size=UDim2.fromOffset(2,height)

        local enemyPoint=Vector2.new(x+width/2,y+height)
        local delta=enemyPoint-screenBottom
        local len=delta.Magnitude
        if Config.EspLine and len>1 then
            local mid=(screenBottom+enemyPoint)*0.5
            local angle=math.deg(math.atan2(delta.Y,delta.X))
            e.tracer.Position=UDim2.fromOffset(mid.X,mid.Y)
            e.tracer.Size=UDim2.fromOffset(len,State.CurrentTarget==char and 2.5 or 1.5)
            e.tracer.Rotation=angle
            e.tracer.BackgroundColor3=boxColor
            e.tracer.Visible=true
            e.tracerGlow.Position=e.tracer.Position
            e.tracerGlow.Size=UDim2.fromOffset(len,State.CurrentTarget==char and 8 or 5)
            e.tracerGlow.Rotation=angle
            e.tracerGlow.Visible=true
        else
            e.tracer.Visible=false
            e.tracerGlow.Visible=false
        end

        local health=getHealth(char)
        local hum=getHumanoid(char)
        local maxHealth=(hum and hum.MaxHealth) or 100
        local pct=math.clamp(health/math.max(maxHealth,1),0,1)

        e.hpBg.Position=UDim2.fromOffset(x,y+height+3)
        e.hpBg.Size=UDim2.fromOffset(width,4)
        e.hpBg.Visible=Config.EspHealthBar
        e.hpFill.Size=UDim2.fromScale(pct,1)
        e.hpFill.BackgroundColor3=pct>0.5 and C.online or (pct>0.25 and Color3.fromRGB(255,200,30) or C.accent)
        e.hpFill.Visible=Config.EspHealthBar and pct>0

        local myRoot=getRoot(player.Character)
        local distance=myRoot and math.floor((myRoot.Position-rootPart.Position).Magnitude) or 0
        if Config.EspDistance or Config.EspHealthBar then
            local parts={}
            if Config.EspHealthBar then table.insert(parts,tostring(math.ceil(health)).." HP") end
            if Config.EspDistance then table.insert(parts,tostring(distance).." m") end
            e.label.Text=table.concat(parts,"  •  ")
            e.label.TextColor3=State.CurrentTarget==char and C.yellow or C.text
            e.label.Position=UDim2.fromOffset(x-20,y+height+(Config.EspHealthBar and 8 or 2))
            e.label.Size=UDim2.fromOffset(width+40,14)
            e.label.Visible=true
        else
            e.label.Visible=false
        end
    end

    for char in pairs(State.ESP) do
        if not active[char] or not char.Parent or not isOpponent(char) then
            removeESP(char)
        end
    end
end
-- =========================================================
-- PLAYER MOVEMENT
-- =========================================================
UIS.JumpRequest:Connect(function()
	if not Config.InfiniteJump then return end
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum and hum.Health > 0 then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local function updateMovement()
	-- WalkSpeed/JumpPower are authoritative on DXServer.
	-- Client only handles camera/visual settings here.
	if camera and camera.FieldOfView ~= Config.FieldOfView then
		camera.FieldOfView = Config.FieldOfView
	end

	if Config.FullBright then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
	else
		Lighting.Brightness = State.OriginalLighting.Brightness
		Lighting.ClockTime = State.OriginalLighting.ClockTime
		Lighting.FogEnd = State.OriginalLighting.FogEnd
		Lighting.GlobalShadows = State.OriginalLighting.GlobalShadows
	end
end

-- =========================================================
-- PERFORMANCE HUD
-- =========================================================
local perf = make("Frame", {
	Name = "PerformanceHUD",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -16, 0, 52),
	Size = UDim2.fromOffset(135, 26),
	BackgroundColor3 = C.side,
	BackgroundTransparency = 0.15,
	BorderSizePixel = 0,
	Visible = Config.ShowPerformanceOverlay,
	ZIndex = 30,
}, gui)
round(perf, 6)

make("UIStroke", {
	Color = C.accent,
	Thickness = 1,
	Transparency = 0.65,
}, perf)

local perfLabel = make("TextLabel", {
	Size = UDim2.fromScale(1,1),
	BackgroundTransparency = 1,
	Text = "FPS 60  |  Ping 0ms",
	TextColor3 = C.text,
	Font = Enum.Font.GothamBold,
	TextSize = 10,
}, perf)

-- FPS/Ping HUD is independently draggable on mouse and touch.
draggable(perf, perf)

-- =========================================================
-- DX FAB
-- =========================================================
local BTN = 50
local toggleBtn = make("TextButton", {
	Size = UDim2.fromOffset(BTN, BTN),
	Position = UDim2.fromOffset(16, math.floor(vp.Y / 2 - BTN / 2)),
	BackgroundColor3 = C.bg,
	Text = "DX",
	Font = Enum.Font.GothamBlack,
	TextSize = 19,
	TextColor3 = Color3.fromRGB(255, 70, 95),
	AutoButtonColor = false,
}, gui)
round(toggleBtn, BTN / 2)

local btnStroke = make("UIStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 2.5,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, toggleBtn)

local btnGrad = make("UIGradient", {Color = neonSeq}, btnStroke)

addGlow(toggleBtn, BTN / 2, {
	{grow = 12, thick = 6, trans = 0.85},
	{grow = 5, thick = 3, trans = 0.65},
})

local btnScale = make("UIScale", {Scale = 1}, toggleBtn)

toggleBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		TweenService:Create(btnScale, TweenInfo.new(0.1), {Scale = 0.88}):Play()
	end
end)

toggleBtn.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		TweenService:Create(btnScale, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Scale = 1}):Play()
	end
end)

local function keepPerfInside()
	local S = gui.AbsoluteSize
	if S.X == 0 or S.Y == 0 then return end
	local p = perf.Position
	local x = p.X.Scale * S.X + p.X.Offset
	local y = p.Y.Scale * S.Y + p.Y.Offset
	local w = perf.AbsoluteSize.X
	local h = perf.AbsoluteSize.Y
	perf.Position = UDim2.fromOffset(
		math.clamp(x, 8, math.max(8, S.X - w - 8)),
		math.clamp(y, 8, math.max(8, S.Y - h - 8))
	)
end

local function keepInside()
	local S = gui.AbsoluteSize
	if S.X == 0 or S.Y == 0 then return end
	local p = toggleBtn.Position
	local x = p.X.Scale * S.X + p.X.Offset
	local y = p.Y.Scale * S.Y + p.Y.Offset
	local nx = math.clamp(x, 8, math.max(8, S.X - BTN - 8))
	local ny = math.clamp(y, 8, math.max(8, S.Y - BTN - 8))
	toggleBtn.Position = UDim2.fromOffset(nx, ny)
end

UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1
		or i.UserInputType == Enum.UserInputType.Touch then
		keepInside()
	end
end)

gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(keepInside)
gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(keepPerfInside)
task.defer(keepInside)
task.defer(keepPerfInside)

-- =========================================================
-- OPEN/CLOSE
-- =========================================================
local open = true
local token = 0

local function setOpen(v)
	open = v
	token += 1
	local my = token

	if v then
		root.Visible = true
		TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()
		TweenService:Create(window, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			GroupTransparency = 0
		}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
	else
		local info = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		TweenService:Create(scale, info, {Scale = 0.88}):Play()
		TweenService:Create(stroke, info, {Transparency = 1}):Play()
		local tw = TweenService:Create(window, info, {GroupTransparency = 1})
		tw:Play()
		tw.Completed:Connect(function()
			if token == my and not open then
				root.Visible = false
			end
		end)
	end
end

scale.Scale = 0.88
window.GroupTransparency = 1
stroke.Transparency = 1
setOpen(true)

draggable(toggleBtn, toggleBtn, function()
	setOpen(not open)
end)

closeBtn.MouseButton1Click:Connect(function()
	setOpen(false)
end)

-- =========================================================
-- HOTKEY: RightShift / Insert
-- =========================================================
UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Insert then
		setOpen(not open)
	end
end)

-- =========================================================
-- RUNTIME LOOP
-- =========================================================
local fpsFrames = 0
local fpsTime = os.clock()
local fps = 60

RunService.RenderStepped:Connect(function(dt)
	local t = os.clock()
	local rot = (t * 90) % 360

	strokeGrad.Rotation = rot
	btnGrad.Rotation = rot
	dot.BackgroundTransparency = 0.45 * (math.sin(t * 3) * 0.5 + 0.5)

	if spin.model and root.Visible and tabs["Overview"].page.Visible then
		spin.angle = (spin.angle + dt * 0.9) % (math.pi * 2)
		spin.model:PivotTo(CFrame.Angles(0, spin.angle, 0))
	end

	if Config.ShowFov and Config.AimAssist then
		local center = Vector2.new(gui.AbsoluteSize.X * 0.5, gui.AbsoluteSize.Y * 0.5)
		fovFrame.Position = UDim2.fromOffset(center.X, center.Y)
		fovFrame.Size = UDim2.fromOffset(Config.FovRadius * 2, Config.FovRadius * 2)
		fovFrame.Visible = true
	else
		fovFrame.Visible = false
	end

	updateESP()
end)

pcall(function()
    RunService:UnbindFromRenderStep("DX_AimAssist")
end)

RunService:BindToRenderStep("DX_AimAssist", Enum.RenderPriority.Camera.Value + 1, function(dt)
    local vp = camera.ViewportSize
    local fovDiameter = Config.FovRadius * 2
    fovFrame.Size = UDim2.fromOffset(fovDiameter, fovDiameter)
    fovFrame.Position = UDim2.fromOffset(vp.X * 0.5, vp.Y * 0.5)
    fovFrame.Visible = Config.ShowFov

    if Config.AimAssist then
        updateTarget()
        aimStep(dt)
    else
        State.CurrentTarget = nil
    end
end)

RunService.Heartbeat:Connect(function()
	updateMovement()

	fpsFrames += 1
	if os.clock() - fpsTime >= 1 then
		fps = fpsFrames
		fpsFrames = 0
		fpsTime = os.clock()
	end

	local ping = 0
	pcall(function()
		ping = math.floor(player:GetNetworkPing() * 1000)
	end)

	perf.Visible = Config.ShowPerformanceOverlay
	perfLabel.Text = string.format("FPS %d  |  Ping %dms", fps, ping)
end)

-- Clean up ESP when players leave
Players.PlayerRemoving:Connect(function(p)
	if p.Character then
		removeESP(p.Character)
	end
end)

-- Reset movement when character respawns
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid", 5)
	task.wait()
	updateMovement()
end)

print("[DX Panel] Single-script DX.txt features initialized.")
