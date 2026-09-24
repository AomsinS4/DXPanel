-- hard-obfuscated build
local __dx_integrity = '66601680b0c254ae'
local __dx_sink = function(...) local _={...}; return _ end

local _aluMQSrN5 = game:GetService("Players")
local _IHEDeLBOa = game:GetService("TweenService")
local _louskFdIb = game:GetService("UserInputService")
local _hYDtquDg6 = game:GetService("RunService")
local _eMuonNlR4 = game:GetService("Lighting")
local _hRcaSMAG9 = game:GetService("Stats")
local _LsLxMrpz29 = _aluMQSrN5.LocalPlayer
local _NMcmvokv56 = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    _NMcmvokv56 = workspace.CurrentCamera
end)
local _aGomvVWk2 = {
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
local _ZZswPhKW8 = {
	CurrentTarget = nil,
	ESP = {},
	OriginalLighting = {
		Brightness = _eMuonNlR4.Brightness,
		ClockTime = _eMuonNlR4.ClockTime,
		FogEnd = _eMuonNlR4.FogEnd,
		GlobalShadows = _eMuonNlR4.GlobalShadows,
	},
}
local _YFyMQItmf = Instance.new("ScreenGui")
_YFyMQItmf.Name = "DXGui"
_YFyMQItmf.ResetOnSpawn = false
_YFyMQItmf.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_YFyMQItmf.IgnoreGuiInset = true
_YFyMQItmf.IgnoreGuiInset = true
_YFyMQItmf.Parent = _LsLxMrpz29:WaitForChild("PlayerGui")
local _bgAoJqbe1 = {
	bg = Color3.fromRGB(8, 8, 11),
	_DirbPpind = Color3.fromRGB(14, 14, 18),
	_NVoptlFj12 = Color3.fromRGB(22, 22, 28),
	accent = Color3.fromRGB(255, 25, 60),
	accent2 = Color3.fromRGB(110, 0, 25),
	off = Color3.fromRGB(50, 50, 58),
	_bRXFEjbV109 = Color3.fromRGB(245, 245, 250),
	sub = Color3.fromRGB(140, 140, 150),
	online = Color3.fromRGB(60, 255, 120),
	yellow = Color3.fromRGB(241, 196, 15),
}
local _XLktryQtc0 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, _bgAoJqbe1.accent),
	ColorSequenceKeypoint.new(0.5, _bgAoJqbe1.accent2),
	ColorSequenceKeypoint.new(1, _bgAoJqbe1.accent),
})
local function _HAnRDzCCb1(_MfEQysnG5d, _urhwnPHmd8, _sWbHjoYscf)
	local _KdHYiOTkc3 = Instance.new(_MfEQysnG5d)
	for k, _mQsSIrIa11a in pairs(_urhwnPHmd8) do _KdHYiOTkc3[k] = _mQsSIrIa11a end
	_KdHYiOTkc3.Parent = _sWbHjoYscf
	return _KdHYiOTkc3
end
local function _ETYaLHUCe6(_KdHYiOTkc3, _LKwAnTFA32)
	_HAnRDzCCb1("UICorner", {CornerRadius = UDim.new(0, _LKwAnTFA32 or 8)}, _KdHYiOTkc3)
end
local function _HPyzDNGz3d(_sWbHjoYscf, _yuplTGJidb, _twXwmVUIa8)
	local _ISavMsjLad = {}
	for _, l in ipairs(_twXwmVUIa8) do
		local _EOqAKaQo79 = _HAnRDzCCb1("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, l.grow, 1, l.grow),
			BackgroundTransparency = 1,
			ZIndex = 0,
		}, _sWbHjoYscf)
		_ETYaLHUCe6(_EOqAKaQo79, _yuplTGJidb + l.grow / 2)
		local _hZgGPJQze8 = _HAnRDzCCb1("UIStroke", {
			Color = _bgAoJqbe1.accent,
			Thickness = l.thick,
			Transparency = l.trans,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		}, _EOqAKaQo79)
		table.insert(_ISavMsjLad, {_LVBtPLtv38 = _hZgGPJQze8, trans = l.trans})
	end
	return _ISavMsjLad
end
local function _sJOQUaZB39(_WxfPUNLY8d, _ENcyzEryff, _xWSnIGZWc7)
	local _oMRpCLVq70, _bCdzhPCZ37, startMouse, startPos, moved = false, nil, nil, nil, 0
	local function _zdvcStfHa1(_UjFkliUw9e)
		return _UjFkliUw9e.UserInputType == Enum.UserInputType.MouseButton1
			or _UjFkliUw9e.UserInputType == Enum.UserInputType.Touch
	end
	_WxfPUNLY8d.InputBegan:Connect(function(_UjFkliUw9e)
		if _oMRpCLVq70 or not _zdvcStfHa1(_UjFkliUw9e) or _aGomvVWk2.GuiLocked then return end
		_oMRpCLVq70 = true
		_bCdzhPCZ37 = _UjFkliUw9e
		startMouse = _UjFkliUw9e.Position
		startPos = _ENcyzEryff.Position
		moved = 0
	end)
	_louskFdIb.InputChanged:Connect(function(_UjFkliUw9e)
		if not _oMRpCLVq70 then return end
		local _diHYdoneb6 = (_UjFkliUw9e == _bCdzhPCZ37)
			or (_bCdzhPCZ37.UserInputType == Enum.UserInputType.MouseButton1
				and _UjFkliUw9e.UserInputType == Enum.UserInputType.MouseMovement)
		if not _diHYdoneb6 then return end
		local _nPAEzMkW72 = _UjFkliUw9e.Position.X - startMouse.X
		local _RbjXwLdF73 = _UjFkliUw9e.Position.Y - startMouse.Y
		moved = math._YCbtXVYSb2(moved, math.sqrt(_nPAEzMkW72 * _nPAEzMkW72 + _RbjXwLdF73 * _RbjXwLdF73))
		_ENcyzEryff.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + _nPAEzMkW72,
			startPos.Y.Scale, startPos.Y.Offset + _RbjXwLdF73
		)
	end)
	_louskFdIb.InputEnded:Connect(function(_UjFkliUw9e)
		if not _oMRpCLVq70 then return end
		local _diHYdoneb6 = (_UjFkliUw9e == _bCdzhPCZ37)
			or (_bCdzhPCZ37.UserInputType == Enum.UserInputType.MouseButton1
				and _UjFkliUw9e.UserInputType == Enum.UserInputType.MouseButton1)
		if not _diHYdoneb6 then return end
		_oMRpCLVq70 = false
		_bCdzhPCZ37 = nil
		if _xWSnIGZWc7 and moved < 6 then _xWSnIGZWc7() end
	end)
end
local _AsyFDkOk121 = _NMcmvokv56.ViewportSize
local _uRyVRoRsc = math.clamp(_AsyFDkOk121.X * 0.85, 300, 520)
local _cpgAXhkF3 = math.clamp(_AsyFDkOk121.Y * 0.75, 240, 340)
local _qxSjfPJif4 = _uRyVRoRsc < 400 and 90 or 120
local _NDkRovhZ16 = _HAnRDzCCb1("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Size = UDim2.fromOffset(_uRyVRoRsc, _cpgAXhkF3),
	Position = UDim2.fromScale(0.5, 0.5),
	BackgroundTransparency = 1,
}, _YFyMQItmf)
local _WorIltuL1a = _HAnRDzCCb1("UIScale", {Scale = 1}, _NDkRovhZ16)
local _HNtPNgaX13 = _HPyzDNGz3d(_NDkRovhZ16, 14, {
	{grow = 14, thick = 7, trans = 0.88},
	{grow = 6, thick = 4, trans = 0.7},
})
local _KJAWzDqL35 = _HAnRDzCCb1("CanvasGroup", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = _bgAoJqbe1.bg,
	GroupTransparency = 0,
	ZIndex = 1,
}, _NDkRovhZ16)
_ETYaLHUCe6(_KJAWzDqL35, 14)
local _LVBtPLtv38 = _HAnRDzCCb1("UIStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 2,
	Transparency = 0,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, _KJAWzDqL35)
local _UlMoLUJK36 = _HAnRDzCCb1("UIGradient", {Color = _XLktryQtc0}, _LVBtPLtv38)
local _kcTRGPFt25 = _HAnRDzCCb1("Frame", {
	Size = UDim2.new(1, 0, 0, 40),
	BackgroundColor3 = _bgAoJqbe1._DirbPpind,
	BorderSizePixel = 0,
}, _KJAWzDqL35)
_HAnRDzCCb1("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 1, -1),
	BackgroundColor3 = _bgAoJqbe1.accent,
	BackgroundTransparency = 0.3,
	BorderSizePixel = 0,
}, _kcTRGPFt25)
local _qUiQwJPK10d = _HAnRDzCCb1("TextLabel", {
	Size = UDim2.new(0, 90, 1, 0),
	Position = UDim2.fromOffset(16, 0),
	BackgroundTransparency = 1,
	Text = "DX Panel",
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamBlack,
	TextSize = 15,
	TextColor3 = _bgAoJqbe1._bRXFEjbV109,
}, _kcTRGPFt25)
_HAnRDzCCb1("UIStroke", {
	Color = _bgAoJqbe1.accent,
	Thickness = 1.2,
	Transparency = 0.45,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
}, _qUiQwJPK10d)
local _yqMLlkzh1b = _HAnRDzCCb1("TextButton", {
	Size = UDim2.fromOffset(26, 26),
	Position = UDim2.new(1, -36, 0.5, -13),
	BackgroundColor3 = _bgAoJqbe1.accent,
	Text = "",
	AutoButtonColor = false,
}, _kcTRGPFt25)
_ETYaLHUCe6(_yqMLlkzh1b, 13)
for _, _jntVLEGke5 in ipairs({45, -45}) do
	local _zfrMoUoA20 = _HAnRDzCCb1("Frame", {
		Size = UDim2.fromOffset(14, 2),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Rotation = _jntVLEGke5,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
	}, _yqMLlkzh1b)
	_ETYaLHUCe6(_zfrMoUoA20, 1)
end
_yqMLlkzh1b.MouseEnter:Connect(function()
	_IHEDeLBOa:Create(_yqMLlkzh1b, TweenInfo.new(0.15), {
		BackgroundColor3 = Color3.fromRGB(255, 90, 110)
	}):Play()
end)
_yqMLlkzh1b.MouseLeave:Connect(function()
	_IHEDeLBOa:Create(_yqMLlkzh1b, TweenInfo.new(0.15), {
		BackgroundColor3 = _bgAoJqbe1.accent
	}):Play()
end)
local _QHGkZptH119 = _HAnRDzCCb1("Frame", {
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -46, 0, 0),
	Size = UDim2.new(0, 120, 1, 0),
	BackgroundTransparency = 1,
}, _kcTRGPFt25)
_HAnRDzCCb1("TextLabel", {
	Position = UDim2.fromOffset(0, 4),
	Size = UDim2.new(1, 0, 0, 17),
	BackgroundTransparency = 1,
	Text = _LsLxMrpz29.DisplayName,
	TextXAlignment = Enum.TextXAlignment.Right,
	TextTruncate = Enum.TextTruncate.AtEnd,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextColor3 = _bgAoJqbe1._bRXFEjbV109,
}, _QHGkZptH119)
local _zXDAeyIMf8 = _HAnRDzCCb1("Frame", {
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 21),
	Size = UDim2.new(0, 0, 0, 14),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
}, _QHGkZptH119)
_HAnRDzCCb1("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 4),
	VerticalAlignment = Enum.VerticalAlignment.Center,
	HorizontalAlignment = Enum.HorizontalAlignment.Left,
}, _zXDAeyIMf8)
local _OQbZKQZq6e = _HAnRDzCCb1("Frame", {
	Size = UDim2.fromOffset(7, 7),
	BackgroundColor3 = _bgAoJqbe1.online,
	LayoutOrder = 1,
}, _zXDAeyIMf8)
_ETYaLHUCe6(_OQbZKQZq6e, 4)
_HAnRDzCCb1("UIStroke", {
	Color = _bgAoJqbe1.online,
	Thickness = 2,
	Transparency = 0.6,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, _OQbZKQZq6e)
_HAnRDzCCb1("TextLabel", {
	Size = UDim2.new(0, 0, 1, 0),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
	Text = "Online",
	LayoutOrder = 2,
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextColor3 = _bgAoJqbe1.online,
}, _zXDAeyIMf8)
_sJOQUaZB39(_kcTRGPFt25, _NDkRovhZ16)
local _DirbPpind = _HAnRDzCCb1("Frame", {
	Size = UDim2.new(0, _qxSjfPJif4, 1, -40),
	Position = UDim2.fromOffset(0, 40),
	BackgroundColor3 = _bgAoJqbe1._DirbPpind,
	BorderSizePixel = 0,
}, _KJAWzDqL35)
_HAnRDzCCb1("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, _DirbPpind)
_HAnRDzCCb1("UIPadding", {
	PaddingTop = UDim.new(0, 10),
	PaddingLeft = UDim.new(0, 8),
	PaddingRight = UDim.new(0, 8),
}, _DirbPpind)
local _HGobftbl33 = _HAnRDzCCb1("Frame", {
	Size = UDim2.new(1, -_qxSjfPJif4, 1, -40),
	Position = UDim2.fromOffset(_qxSjfPJif4, 40),
	BackgroundTransparency = 1,
}, _KJAWzDqL35)
local _SBSYAjqZ18 = {}
local function _tlAwaWVI19(_ntIXXJGobc)
	for _bUoDmLlKbb, _ICCBxncCfd in pairs(_SBSYAjqZ18) do
		local _qulEoRNSc6 = (_bUoDmLlKbb == _ntIXXJGobc)
		_ICCBxncCfd._lWpVJWUJ21.Visible = _qulEoRNSc6
		_IHEDeLBOa:Create(_ICCBxncCfd._YldDDEDm14, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			BackgroundColor3 = _qulEoRNSc6 and _bgAoJqbe1.accent or _bgAoJqbe1._NVoptlFj12,
			TextColor3 = _qulEoRNSc6 and Color3.new(1, 1, 1) or _bgAoJqbe1.sub,
		}):Play()
		_IHEDeLBOa:Create(_ICCBxncCfd._LVBtPLtv38, TweenInfo.new(0.2), {
			Transparency = _qulEoRNSc6 and 0.1 or 0.85
		}):Play()
	end
end
local function _eKMQvoVc30(_ntIXXJGobc)
	local _YldDDEDm14 = _HAnRDzCCb1("TextButton", {
		Size = UDim2.new(1, 0, 0, 32),
		BackgroundColor3 = _bgAoJqbe1._NVoptlFj12,
		Text = _ntIXXJGobc,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = _bgAoJqbe1.sub,
		AutoButtonColor = false,
	}, _DirbPpind)
	_ETYaLHUCe6(_YldDDEDm14, 8)
	local _nRNceAbz50 = _HAnRDzCCb1("UIStroke", {
		Color = _bgAoJqbe1.accent,
		Thickness = 1,
		Transparency = 0.85,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, _YldDDEDm14)
	local _lWpVJWUJ21 = _HAnRDzCCb1("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = _bgAoJqbe1.accent,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		Visible = false,
	}, _HGobftbl33)
	_HAnRDzCCb1("UIListLayout", {
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, _lWpVJWUJ21)
	_HAnRDzCCb1("UIPadding", {
		PaddingTop = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
	}, _lWpVJWUJ21)
	_SBSYAjqZ18[_ntIXXJGobc] = {_YldDDEDm14 = _YldDDEDm14, _lWpVJWUJ21 = _lWpVJWUJ21, _LVBtPLtv38 = _nRNceAbz50}
	_YldDDEDm14.MouseButton1Click:Connect(function() _tlAwaWVI19(_ntIXXJGobc) end)
	return _lWpVJWUJ21
end
local function _NVoptlFj12(_lWpVJWUJ21, _hItGpLql8c)
	local _LKwAnTFA32 = _HAnRDzCCb1("Frame", {
		Size = UDim2.new(1, 0, 0, _hItGpLql8c or 36),
		BackgroundColor3 = _bgAoJqbe1._NVoptlFj12,
	}, _lWpVJWUJ21)
	_ETYaLHUCe6(_LKwAnTFA32, 8)
	_HAnRDzCCb1("UIStroke", {
		Color = _bgAoJqbe1.accent,
		Thickness = 1,
		Transparency = 0.82,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, _LKwAnTFA32)
	return _LKwAnTFA32
end
local function _ZvxPNJyp2b(_sWbHjoYscf, _bRXFEjbV109, _qpNkxwdn122)
	return _HAnRDzCCb1("TextLabel", {
		Size = UDim2.new(_qpNkxwdn122 or 1, -12, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		BackgroundTransparency = 1,
		Text = _bRXFEjbV109,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = _bgAoJqbe1._bRXFEjbV109,
	}, _sWbHjoYscf)
end
local function _KfnyIVbl17(_lWpVJWUJ21, _bRXFEjbV109)
	_HAnRDzCCb1("TextLabel", {
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = _bRXFEjbV109,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextColor3 = _bgAoJqbe1.accent,
	}, _lWpVJWUJ21)
end
local function _uqAwjWPV1f(_lWpVJWUJ21, _bRXFEjbV109, _IOjrVdFp5a)
	local _LKwAnTFA32 = _NVoptlFj12(_lWpVJWUJ21)
	local _sTqAzIFs46 = _HAnRDzCCb1("TextButton", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = _bRXFEjbV109,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextColor3 = _bgAoJqbe1._bRXFEjbV109,
	}, _LKwAnTFA32)
	_sTqAzIFs46.MouseButton1Click:Connect(function()
		_IHEDeLBOa:Create(_LKwAnTFA32, TweenInfo.new(0.08), {
			BackgroundColor3 = _bgAoJqbe1.accent
		}):Play()
		task.delay(0.1, function()
			if _LKwAnTFA32.Parent then
				_IHEDeLBOa:Create(_LKwAnTFA32, TweenInfo.new(0.25), {
					BackgroundColor3 = _bgAoJqbe1._NVoptlFj12
				}):Play()
			end
		end)
		if _IOjrVdFp5a then _IOjrVdFp5a() end
	end)
	return _sTqAzIFs46
end
local function _DIozLJVZ2d(_lWpVJWUJ21, _bRXFEjbV109, _GSCevXzz68, _IOjrVdFp5a)
	local _LKwAnTFA32 = _NVoptlFj12(_lWpVJWUJ21)
	_ZvxPNJyp2b(_LKwAnTFA32, _bRXFEjbV109, 0.7)
	local _kOqCQWww1e = _GSCevXzz68
	local _hWrzLquVd4 = _HAnRDzCCb1("TextButton", {
		Size = UDim2.fromOffset(40, 20),
		Position = UDim2.new(1, -52, 0.5, -10),
		BackgroundColor3 = _kOqCQWww1e and _bgAoJqbe1.accent or _bgAoJqbe1.off,
		Text = "",
		AutoButtonColor = false,
	}, _LKwAnTFA32)
	_ETYaLHUCe6(_hWrzLquVd4, 10)
	local _tuZheavyd9 = _HAnRDzCCb1("UIStroke", {
		Color = _bgAoJqbe1.accent,
		Thickness = 3,
		Transparency = _kOqCQWww1e and 0.6 or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, _hWrzLquVd4)
	local _PsOkxqiga4 = _HAnRDzCCb1("Frame", {
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Position = _kOqCQWww1e and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2),
	}, _hWrzLquVd4)
	_ETYaLHUCe6(_PsOkxqiga4, 8)
	_hWrzLquVd4.MouseButton1Click:Connect(function()
		_kOqCQWww1e = not _kOqCQWww1e
		local _KokZaAPj9d = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		_IHEDeLBOa:Create(_hWrzLquVd4, _KokZaAPj9d, {
			BackgroundColor3 = _kOqCQWww1e and _bgAoJqbe1.accent or _bgAoJqbe1.off
		}):Play()
		_IHEDeLBOa:Create(_tuZheavyd9, _KokZaAPj9d, {
			Transparency = _kOqCQWww1e and 0.6 or 1
		}):Play()
		_IHEDeLBOa:Create(_PsOkxqiga4, _KokZaAPj9d, {
			Position = _kOqCQWww1e and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
		}):Play()
		if _IOjrVdFp5a then _IOjrVdFp5a(_kOqCQWww1e) end
	end)
end
local function _yxRHXvsQ23(_lWpVJWUJ21, _bRXFEjbV109, _IsLTiCJjb5, _YCbtXVYSb2, _GSCevXzz68, _IOjrVdFp5a, _HPBUULiAfc)
	local _LKwAnTFA32 = _NVoptlFj12(_lWpVJWUJ21, 50)
	local _TqDvDhCOa9 = _ZvxPNJyp2b(_LKwAnTFA32, _bRXFEjbV109 .. ": " .. tostring(_GSCevXzz68) .. (_HPBUULiAfc or ""))
	_TqDvDhCOa9.Size = UDim2.new(1, -12, 0, 26)
	local _zfrMoUoA20 = _HAnRDzCCb1("Frame", {
		Size = UDim2.new(1, -24, 0, 6),
		Position = UDim2.new(0, 12, 0, 34),
		BackgroundColor3 = _bgAoJqbe1.off,
	}, _LKwAnTFA32)
	_ETYaLHUCe6(_zfrMoUoA20, 3)
	local _tBmywsdj34 = _HAnRDzCCb1("Frame", {
		Size = UDim2.fromScale((_GSCevXzz68 - _IsLTiCJjb5) / (_YCbtXVYSb2 - _IsLTiCJjb5), 1),
		BackgroundColor3 = _bgAoJqbe1.accent,
	}, _zfrMoUoA20)
	_ETYaLHUCe6(_tBmywsdj34, 3)
	_HAnRDzCCb1("UIStroke", {
		Color = _bgAoJqbe1.accent,
		Thickness = 3,
		Transparency = 0.65,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, _tBmywsdj34)
	_HAnRDzCCb1("UIGradient", {
		Color = ColorSequence.new(_bgAoJqbe1.accent2, _bgAoJqbe1.accent)
	}, _tBmywsdj34)
	local _bCdzhPCZ37 = nil
	local function _KtrongYe22(_VuInPXXK126)
		local _CTmYyIHP3a = math.clamp(
			(_VuInPXXK126 - _zfrMoUoA20.AbsolutePosition.X) / math._YCbtXVYSb2(_zfrMoUoA20.AbsoluteSize.X, 1),
			0, 1
		)
		local _mQsSIrIa11a = math.floor(_IsLTiCJjb5 + (_YCbtXVYSb2 - _IsLTiCJjb5) * _CTmYyIHP3a + 0.5)
		_tBmywsdj34.Size = UDim2.fromScale(_CTmYyIHP3a, 1)
		_TqDvDhCOa9.Text = _bRXFEjbV109 .. ": " .. tostring(_mQsSIrIa11a) .. (_HPBUULiAfc or "")
		if _IOjrVdFp5a then _IOjrVdFp5a(_mQsSIrIa11a) end
	end
	_LKwAnTFA32.InputBegan:Connect(function(_LTXVxIsb9b)
		if _bCdzhPCZ37 then return end
		if _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseButton1
			or _LTXVxIsb9b.UserInputType == Enum.UserInputType.Touch then
			_bCdzhPCZ37 = _LTXVxIsb9b
			_KtrongYe22(_LTXVxIsb9b.Position.X)
		end
	end)
	_louskFdIb.InputChanged:Connect(function(_LTXVxIsb9b)
		if not _bCdzhPCZ37 then return end
		if _LTXVxIsb9b == _bCdzhPCZ37
			or (_bCdzhPCZ37.UserInputType == Enum.UserInputType.MouseButton1
				and _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseMovement) then
			_KtrongYe22(_LTXVxIsb9b.Position.X)
		end
	end)
	_louskFdIb.InputEnded:Connect(function(_LTXVxIsb9b)
		if not _bCdzhPCZ37 then return end
		if _LTXVxIsb9b == _bCdzhPCZ37
			or (_bCdzhPCZ37.UserInputType == Enum.UserInputType.MouseButton1
				and _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseButton1) then
			_bCdzhPCZ37 = nil
		end
	end)
end
local _rWsCNsap15 = _eKMQvoVc30("Overview")
local _cdXmsqvb2c = {model = nil, _oNTVDmpY44 = 0}
_KfnyIVbl17(_rWsCNsap15, "CHARACTER")
do
	local _iPkgsjdj59 = _NVoptlFj12(_rWsCNsap15, 180)
	local _GrqQGZPl28 = _HAnRDzCCb1("ViewportFrame", {
		Position = UDim2.fromOffset(8, 8),
		Size = UDim2.new(0.5, -12, 1, -16),
		BackgroundColor3 = _bgAoJqbe1.bg,
		BorderSizePixel = 0,
		Ambient = Color3.fromRGB(170, 170, 180),
		LightColor = Color3.fromRGB(255, 255, 255),
		LightDirection = Vector3.new(-1, -1, 1),
	}, _iPkgsjdj59)
	_ETYaLHUCe6(_GrqQGZPl28, 8)
	_HAnRDzCCb1("UIStroke", {
		Color = _bgAoJqbe1.accent,
		Thickness = 1,
		Transparency = 0.6,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, _GrqQGZPl28)
	local _HjaMKVNC10 = _HAnRDzCCb1("Camera", {FieldOfView = 35}, _GrqQGZPl28)
	_HjaMKVNC10.CFrame = CFrame.new(Vector3.new(0, 0.3, -10), Vector3.new(0, -0.2, 0))
	_GrqQGZPl28.CurrentCamera = _HjaMKVNC10
	_HAnRDzCCb1("TextLabel", {
		Position = UDim2.new(0.5, 4, 0, 8),
		Size = UDim2.new(0.5, -12, 1, -82),
		BackgroundTransparency = 1,
		RichText = true,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = _bgAoJqbe1.sub,
		Text = string.format(
			'<font color="#F5F5FA" size="14"><b>%s</b></font>\n@%s\nID: %d',
			_LsLxMrpz29.DisplayName, _LsLxMrpz29.Name, _LsLxMrpz29.UserId
		),
	}, _iPkgsjdj59)
	local _eYLjxkonf6 = _HAnRDzCCb1("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0.5, 4, 1, -8),
		Size = UDim2.new(0.5, -12, 0, 58),
		BackgroundTransparency = 1,
	}, _iPkgsjdj59)
	_HAnRDzCCb1("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = _bgAoJqbe1.accent,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
	}, _eYLjxkonf6)
	_HAnRDzCCb1("TextLabel", {
		Position = UDim2.fromOffset(0, 8),
		Size = UDim2.new(0.5, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = "Players",
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextColor3 = _bgAoJqbe1.sub,
	}, _eYLjxkonf6)
	local _CzgcNfqU11b = _HAnRDzCCb1("TextLabel", {
		Position = UDim2.new(0.5, 0, 0, 8),
		Size = UDim2.new(0.5, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = "0 / 0",
		TextXAlignment = Enum.TextXAlignment.Right,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextColor3 = _bgAoJqbe1.accent,
	}, _eYLjxkonf6)
	local _zfrMoUoA20 = _HAnRDzCCb1("Frame", {
		Position = UDim2.fromOffset(0, 38),
		Size = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = _bgAoJqbe1.off,
	}, _eYLjxkonf6)
	_ETYaLHUCe6(_zfrMoUoA20, 3)
	local _tBmywsdj34 = _HAnRDzCCb1("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = _bgAoJqbe1.accent,
	}, _zfrMoUoA20)
	_ETYaLHUCe6(_tBmywsdj34, 3)
	local function _StFuVQBm24()
		local _bUoDmLlKbb = #_aluMQSrN5:GetPlayers()
		local _gTBJhLfoaf = math._YCbtXVYSb2(_aluMQSrN5.MaxPlayers, 1)
		_CzgcNfqU11b.Text = _bUoDmLlKbb .. " / " .. _gTBJhLfoaf
		_IHEDeLBOa:Create(_tBmywsdj34, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
			Size = UDim2.fromScale(math.clamp(_bUoDmLlKbb / _gTBJhLfoaf, 0, 1), 1),
		}):Play()
	end
	_StFuVQBm24()
	_aluMQSrN5.PlayerAdded:Connect(function() task.defer(_StFuVQBm24) end)
	_aluMQSrN5.PlayerRemoving:Connect(function() task.delay(0.2, _StFuVQBm24) end)
	local function _CYQlqUIO31()
		for _, c in ipairs(_GrqQGZPl28:GetChildren()) do
			if c:IsA("Model") then c:Destroy() end
		end
		_cdXmsqvb2c.model = nil
	end
	local function _KPTobBNp2a(_fXDgCiFi5c)
		_CYQlqUIO31()
		if not _fXDgCiFi5c then return end
		local _WbbDuYjJ99 = _fXDgCiFi5c:WaitForChild("HumanoidRootPart", 5)
		if not _WbbDuYjJ99 then return end
		local _oVWTCyAlc5 = _fXDgCiFi5c.Archivable
		_fXDgCiFi5c.Archivable = true
		local _oRRDDFoX5f = _fXDgCiFi5c:Clone()
		_fXDgCiFi5c.Archivable = _oVWTCyAlc5
		if not _oRRDDFoX5f then return end
		for _, d in ipairs(_oRRDDFoX5f:GetDescendants()) do
			if d:IsA("BaseScript") or d:IsA("Sound") then
				d:Destroy()
			elseif d:IsA("BasePart") then
				d.Anchored = true
			end
		end
		local _ZdmMKYKb9a = _oRRDDFoX5f:FindFirstChildOfClass("Humanoid")
		if _ZdmMKYKb9a then
			_ZdmMKYKb9a.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end
		_oRRDDFoX5f.Parent = _GrqQGZPl28
		_oRRDDFoX5f:PivotTo(CFrame.new())
		_cdXmsqvb2c.model = _oRRDDFoX5f
	end
	task.spawn(function()
		_KPTobBNp2a(_LsLxMrpz29.Character or _LsLxMrpz29.CharacterAdded:Wait())
	end)
	_LsLxMrpz29.CharacterAdded:Connect(function(_fXDgCiFi5c)
		task.spawn(_KPTobBNp2a, _fXDgCiFi5c)
	end)
end
local _bJvwxcGN61 = _eKMQvoVc30("Combat")
_KfnyIVbl17(_bJvwxcGN61, "AIM ASSIST")
_DIozLJVZ2d(_bJvwxcGN61, "Enable Aim Assist", _aGomvVWk2.AimAssist, function(_mQsSIrIa11a)
	_aGomvVWk2.AimAssist = _mQsSIrIa11a
	if not _mQsSIrIa11a then _ZZswPhKW8.CurrentTarget = nil end
end)
_yxRHXvsQ23(_bJvwxcGN61, "Aim Strength", _aGomvVWk2.MinStrength, _aGomvVWk2.MaxStrength, _aGomvVWk2.AimStrength,
	function(_mQsSIrIa11a) _aGomvVWk2.AimStrength = _mQsSIrIa11a end, "%")
_yxRHXvsQ23(_bJvwxcGN61, "Max Distance", _aGomvVWk2.MinDistance, _aGomvVWk2.MaxDistanceLimit, _aGomvVWk2.MaxDistance,
	function(_mQsSIrIa11a) _aGomvVWk2.MaxDistance = _mQsSIrIa11a end, " STUD")
_yxRHXvsQ23(_bJvwxcGN61, "FOV Radius", _aGomvVWk2.MinFov, _aGomvVWk2.MaxFov, _aGomvVWk2.FovRadius,
	function(_mQsSIrIa11a) _aGomvVWk2.FovRadius = _mQsSIrIa11a end, " PX")
_KfnyIVbl17(_bJvwxcGN61, "TARGETING")
_DIozLJVZ2d(_bJvwxcGN61, "Show FOV Circle", _aGomvVWk2.ShowFov, function(_mQsSIrIa11a)
	_aGomvVWk2.ShowFov = _mQsSIrIa11a
end)
_DIozLJVZ2d(_bJvwxcGN61, "Team Check", _aGomvVWk2.TeamCheck, function(_mQsSIrIa11a)
	_aGomvVWk2.TeamCheck = _mQsSIrIa11a
end)
local _zQqbVYkB4d = {"Head", "Torso", "Random"}
local _oIvRfqdP4c = 1
local _EeDQDQfM4b
_EeDQDQfM4b = _uqAwjWPV1f(_bJvwxcGN61, "Target Bone: " .. _aGomvVWk2.TargetPart, function()
	_oIvRfqdP4c = (_oIvRfqdP4c % #_zQqbVYkB4d) + 1
	_aGomvVWk2.TargetPart = _zQqbVYkB4d[_oIvRfqdP4c]
	_EeDQDQfM4b.Text = "Target Bone: " .. _aGomvVWk2.TargetPart
end)
local _bFHwPmUO120 = _eKMQvoVc30("Visuals")
_KfnyIVbl17(_bFHwPmUO120, "ESP OVERLAY")
_DIozLJVZ2d(_bFHwPmUO120, "Enable Player ESP", _aGomvVWk2.PlayerESP, function(_mQsSIrIa11a)
	_aGomvVWk2.PlayerESP = _mQsSIrIa11a
	if not _mQsSIrIa11a then
		for _fXDgCiFi5c in pairs(_ZZswPhKW8.ESP) do
			_ZZswPhKW8.ESP[_fXDgCiFi5c]:Destroy()
			_ZZswPhKW8.ESP[_fXDgCiFi5c] = nil
		end
	end
end)
_DIozLJVZ2d(_bFHwPmUO120, "Bounding Box", _aGomvVWk2.EspBox, function(_mQsSIrIa11a)
	_aGomvVWk2.EspBox = _mQsSIrIa11a
end)
_DIozLJVZ2d(_bFHwPmUO120, "Health Bar", _aGomvVWk2.EspHealthBar, function(_mQsSIrIa11a)
	_aGomvVWk2.EspHealthBar = _mQsSIrIa11a
end)
_DIozLJVZ2d(_bFHwPmUO120, "Distance Tags", _aGomvVWk2.EspDistance, function(_mQsSIrIa11a)
	_aGomvVWk2.EspDistance = _mQsSIrIa11a
end)
_DIozLJVZ2d(_bFHwPmUO120, "Enemy Tracer Line", _aGomvVWk2.EspLine, function(_mQsSIrIa11a)
	_aGomvVWk2.EspLine = _mQsSIrIa11a
end)
_KfnyIVbl17(_bFHwPmUO120, "VISUAL FILTERS")
_DIozLJVZ2d(_bFHwPmUO120, "Enemy Only / Team Check", _aGomvVWk2.TeamCheck, function(_mQsSIrIa11a)
	_aGomvVWk2.TeamCheck = _mQsSIrIa11a
end)
local _pHwENCwa27 = _eKMQvoVc30("Main")
_KfnyIVbl17(_pHwENCwa27, "MOVEMENT")
_yxRHXvsQ23(_pHwENCwa27, "Walk Speed", 16, 150, _aGomvVWk2.WalkSpeed,
	function(_mQsSIrIa11a) _aGomvVWk2.WalkSpeed = _mQsSIrIa11a end)
_yxRHXvsQ23(_pHwENCwa27, "Jump Power", 50, 250, _aGomvVWk2.JumpPower,
	function(_mQsSIrIa11a) _aGomvVWk2.JumpPower = _mQsSIrIa11a end)
_DIozLJVZ2d(_pHwENCwa27, "Infinite Jump", _aGomvVWk2.InfiniteJump, function(_mQsSIrIa11a)
	_aGomvVWk2.InfiniteJump = _mQsSIrIa11a
end)
_KfnyIVbl17(_pHwENCwa27, "WORLD")
_yxRHXvsQ23(_pHwENCwa27, "Field Of View", 70, 120, _aGomvVWk2.FieldOfView,
	function(_mQsSIrIa11a) _aGomvVWk2.FieldOfView = _mQsSIrIa11a end)
_DIozLJVZ2d(_pHwENCwa27, "Full Bright", _aGomvVWk2.FullBright, function(_mQsSIrIa11a)
	_aGomvVWk2.FullBright = _mQsSIrIa11a
end)
local _yYWYbBGU26 = _eKMQvoVc30("Settings")
_KfnyIVbl17(_yYWYbBGU26, "INTERFACE")
_DIozLJVZ2d(_yYWYbBGU26, "Lock GUI Position", _aGomvVWk2.GuiLocked, function(_mQsSIrIa11a)
	_aGomvVWk2.GuiLocked = _mQsSIrIa11a
end)
_DIozLJVZ2d(_yYWYbBGU26, "Ping & FPS Overlay", _aGomvVWk2.ShowPerformanceOverlay, function(_mQsSIrIa11a)
	_aGomvVWk2.ShowPerformanceOverlay = _mQsSIrIa11a
end)
_uqAwjWPV1f(_yYWYbBGU26, "Reset Defaults", function()
	_aGomvVWk2.AimAssist = false
	_aGomvVWk2.AimStrength = 75
	_aGomvVWk2.MaxDistance = 500
	_aGomvVWk2.FovRadius = 180
	_aGomvVWk2.ShowFov = true
	_aGomvVWk2.TargetPart = "Head"
	_aGomvVWk2.PlayerESP = false
	_aGomvVWk2.EspBox = true
	_aGomvVWk2.EspHealthBar = true
	_aGomvVWk2.EspDistance = true
	_aGomvVWk2.EspLine = true
	_aGomvVWk2.TeamCheck = true
	_aGomvVWk2.WalkSpeed = 16
	_aGomvVWk2.JumpPower = 50
	_aGomvVWk2.InfiniteJump = false
	_aGomvVWk2.FieldOfView = 70
	_aGomvVWk2.FullBright = false
	_ZZswPhKW8.CurrentTarget = nil
end)
_uqAwjWPV1f(_yYWYbBGU26, "Unload Script", function()
	for _fXDgCiFi5c, obj in pairs(_ZZswPhKW8.ESP) do
		if obj then obj:Destroy() end
	end
	_ZZswPhKW8.ESP = {}
	_eMuonNlR4.Brightness = _ZZswPhKW8.OriginalLighting.Brightness
	_eMuonNlR4.ClockTime = _ZZswPhKW8.OriginalLighting.ClockTime
	_eMuonNlR4.FogEnd = _ZZswPhKW8.OriginalLighting.FogEnd
	_eMuonNlR4.GlobalShadows = _ZZswPhKW8.OriginalLighting.GlobalShadows
	pcall(function() _hYDtquDg6:UnbindFromRenderStep("DX_AimAssist") end)
	if _YFyMQItmf then _YFyMQItmf:Destroy() end
end)
_tlAwaWVI19("Overview")
local _GVrVDgJH7d = _HAnRDzCCb1("Frame", {
	Name = "FovCircle",
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 5,
}, _YFyMQItmf)
_ETYaLHUCe6(_GVrVDgJH7d, 999)
_HAnRDzCCb1("UIStroke", {
	Color = _bgAoJqbe1.accent,
	Thickness = 1.2,
	Transparency = 0.4,
}, _GVrVDgJH7d)
local function _oFRetILh87(_fXDgCiFi5c)
	if not _fXDgCiFi5c then return nil end
	return _fXDgCiFi5c:FindFirstChild("HumanoidRootPart")
		or _fXDgCiFi5c:FindFirstChild("UpperTorso")
		or _fXDgCiFi5c:FindFirstChild("Torso")
end
local function _ueIyOvzr84(_fXDgCiFi5c)
	if not _fXDgCiFi5c then return nil end
	return _fXDgCiFi5c:FindFirstChild("Head") or _oFRetILh87(_fXDgCiFi5c)
end
local function _MAwFcRrl86(_fXDgCiFi5c)
	return _fXDgCiFi5c and _fXDgCiFi5c:FindFirstChildOfClass("Humanoid")
end
local function _dNBkUAqH85(_fXDgCiFi5c)
	local _ZdmMKYKb9a = _MAwFcRrl86(_fXDgCiFi5c)
	return _ZdmMKYKb9a and _ZdmMKYKb9a.Health or 0
end
local function _yPQjCTuY88(_quaOHgMt77)
    if not _quaOHgMt77 then return nil end
    local _fXDgCiFi5c
    if typeof(_quaOHgMt77) == "Instance" and _quaOHgMt77:IsA("Model") then
        _fXDgCiFi5c = _quaOHgMt77
    elseif typeof(_quaOHgMt77) == "Instance" and _quaOHgMt77:IsA("Player") then
        _fXDgCiFi5c = _quaOHgMt77.Character
    end
    if _fXDgCiFi5c then
        local _vvlkZhPH45 = _fXDgCiFi5c:GetAttribute("Team")
            or _fXDgCiFi5c:GetAttribute("Faction")
            or _fXDgCiFi5c:GetAttribute("TeamName")
        if _vvlkZhPH45 ~= nil then
            return tostring(_vvlkZhPH45)
        end
    end
    local _dsTWQDRv104
    if typeof(_quaOHgMt77) == "Instance" and _quaOHgMt77:IsA("Player") then
        _dsTWQDRv104 = _quaOHgMt77
    elseif _fXDgCiFi5c then
        _dsTWQDRv104 = _aluMQSrN5:GetPlayerFromCharacter(_fXDgCiFi5c) or _aluMQSrN5:FindFirstChild(_fXDgCiFi5c.Name)
    end
    if _dsTWQDRv104 then
        local _scdszvaocc = _dsTWQDRv104:GetAttribute("Team")
            or _dsTWQDRv104:GetAttribute("TeamName")
            or _dsTWQDRv104:GetAttribute("Faction")
        if _scdszvaocc ~= nil then
            return tostring(_scdszvaocc)
        end
        if _dsTWQDRv104.Team ~= nil then
            return _dsTWQDRv104.Team.Name
        end
        if not _dsTWQDRv104.Neutral and _dsTWQDRv104.TeamColor then
            return _dsTWQDRv104.TeamColor.Name
        end
    end
    return nil
end
local function _NMjQFxUwa0(_fXDgCiFi5c)
    if not _fXDgCiFi5c or _fXDgCiFi5c == _LsLxMrpz29.Character or _fXDgCiFi5c.Name == _LsLxMrpz29.Name then
        return false
    end
    local _tcZngWQNe3 = _oFRetILh87(_fXDgCiFi5c)
    if not _tcZngWQNe3 then
        return false
    end
    if _dNBkUAqH85(_fXDgCiFi5c) <= 0 then
        return false
    end
    local _KeeDOyWVba = _yPQjCTuY88(_LsLxMrpz29)
    local _iZuuvpnF108 = _yPQjCTuY88(_fXDgCiFi5c)
    if _KeeDOyWVba ~= nil and _iZuuvpnF108 ~= nil then
        if _KeeDOyWVba == "Vanguards" then
            return _iZuuvpnF108 == "Phantoms"
        elseif _KeeDOyWVba == "Phantoms" then
            return _iZuuvpnF108 == "Vanguards"
        else
            return _KeeDOyWVba ~= _iZuuvpnF108
        end
    end
    return true
end
local function _ENSQLaFM83()
	local _erNvjqtNe0, seen = {}, {}
	local _sycrNNYwae = workspace:FindFirstChild("Live")
	if _sycrNNYwae then
		for _, _fXDgCiFi5c in ipairs(_sycrNNYwae:GetChildren()) do
			if _fXDgCiFi5c:IsA("Model") and not seen[_fXDgCiFi5c] and _NMjQFxUwa0(_fXDgCiFi5c) then
				seen[_fXDgCiFi5c] = true
				table.insert(_erNvjqtNe0, _fXDgCiFi5c)
			end
		end
	end
	for _, _JXDQJxspcb in ipairs(_aluMQSrN5:GetPlayers()) do
		if _JXDQJxspcb ~= _LsLxMrpz29 and _JXDQJxspcb.Character and not seen[_JXDQJxspcb.Character] and _NMjQFxUwa0(_JXDQJxspcb.Character) then
			seen[_JXDQJxspcb.Character] = true
			table.insert(_erNvjqtNe0, _JXDQJxspcb.Character)
		end
	end
	return _erNvjqtNe0
end
local function _eWyEhbVC9f(_fXDgCiFi5c, _aYcMmRRPb7)
	local _JkrLlnxU8f = _ueIyOvzr84(_fXDgCiFi5c)
	local _tcZngWQNe3 = _oFRetILh87(_fXDgCiFi5c)
	if not _JkrLlnxU8f and not _tcZngWQNe3 then return false end
	local _TJbfkEDE11e = _NMcmvokv56.ViewportSize
	local _kYXOUosy5b = Vector2.new(_TJbfkEDE11e.X / 2, _TJbfkEDE11e.Y / 2)
	local _yuplTGJidb = _aGomvVWk2.FovRadius * (_aYcMmRRPb7 or 1)
	for _, part in ipairs({_JkrLlnxU8f, _tcZngWQNe3}) do
		if part then
			local _JXDQJxspcb, onScreen = _NMcmvokv56:WorldToViewportPoint(part.Position)
			if onScreen and _JXDQJxspcb.Z > 0 then
				local _BtmiGmmA6b = (Vector2.new(_JXDQJxspcb.X, _JXDQJxspcb.Y) - _kYXOUosy5b).Magnitude
				if _BtmiGmmA6b <= _yuplTGJidb then return true end
			end
		end
	end
	return false
end
local function _MqNMxnzb8e(_AOAdjcaI101, _wfjrDyJk103)
    if not _wfjrDyJk103 or not _NMcmvokv56 then return false end
    local _uLtQidMzc9 = _NMcmvokv56.CFrame.Position
    local _DQantbkE6a = _wfjrDyJk103.Position - _uLtQidMzc9
    local _uBRcpJFLce = RaycastParams.new()
    _uBRcpJFLce.FilterType = Enum.RaycastFilterType.Exclude
    _uBRcpJFLce.IgnoreWater = true
    local _TbLZRIws9c = {_LsLxMrpz29.Character}
    if _NMcmvokv56 then table.insert(_TbLZRIws9c, _NMcmvokv56) end
    _uBRcpJFLce.FilterDescendantsInstances = _TbLZRIws9c
    local _csPVUVvr93 = workspace:Raycast(_uLtQidMzc9, _DQantbkE6a, _uBRcpJFLce)
    if not _csPVUVvr93 then
        return true
    end
    return _csPVUVvr93.Instance:IsDescendantOf(_AOAdjcaI101)
end
local function _DznvKybf7b()
    local _PaMydrqQb9 = _oFRetILh87(_LsLxMrpz29.Character)
    if not _PaMydrqQb9 then return nil end
    local _NALkMTZh49 = nil
    local _EGVESjkx48 = math.huge
    local _gzqEPJqD4a = math.huge
    local _TJbfkEDE11e = _NMcmvokv56.ViewportSize
    local _kYXOUosy5b = Vector2.new(_TJbfkEDE11e.X * 0.5, _TJbfkEDE11e.Y * 0.5)
    for _, _fXDgCiFi5c in ipairs(_ENSQLaFM83()) do
        local _HZKlRqpD96 = _dNBkUAqH85(_fXDgCiFi5c)
        local _tcZngWQNe3 = _oFRetILh87(_fXDgCiFi5c)
        local _JkrLlnxU8f = _ueIyOvzr84(_fXDgCiFi5c)
        if _HZKlRqpD96 > 0 and _tcZngWQNe3 then
            local _xUtgdtcy125 = (_PaMydrqQb9.Position - _tcZngWQNe3.Position).Magnitude
            if _xUtgdtcy125 <= _aGomvVWk2.MaxDistance then
                local _WtzGCSuJ58 = _JkrLlnxU8f or _tcZngWQNe3
                local _YdKDtuAvea, onScreen = _NMcmvokv56:WorldToViewportPoint(_WtzGCSuJ58.Position)
                if onScreen and _YdKDtuAvea.Z > 0 then
                    local _YYxfDTDhec = (Vector2.new(_YdKDtuAvea.X, _YdKDtuAvea.Y) - _kYXOUosy5b).Magnitude
                    if _YYxfDTDhec <= _aGomvVWk2.FovRadius and _MqNMxnzb8e(_fXDgCiFi5c, _WtzGCSuJ58) then
                        if _YYxfDTDhec < _EGVESjkx48
                            or (math.abs(_YYxfDTDhec - _EGVESjkx48) < 0.5 and _xUtgdtcy125 < _gzqEPJqD4a) then
                            _NALkMTZh49 = _fXDgCiFi5c
                            _EGVESjkx48 = _YYxfDTDhec
                            _gzqEPJqD4a = _xUtgdtcy125
                        end
                    end
                end
            end
        end
    end
    return _NALkMTZh49
end
local _GWByACZedc = "Head"
local function _yGaZhVql118()
    if not _aGomvVWk2.AimAssist then
        _ZZswPhKW8.CurrentTarget = nil
        return
    end
    if _ZZswPhKW8.CurrentTarget then
        if not _NMjQFxUwa0(_ZZswPhKW8.CurrentTarget)
            or _dNBkUAqH85(_ZZswPhKW8.CurrentTarget) <= 0
            or not _eWyEhbVC9f(_ZZswPhKW8.CurrentTarget, 1.25)
            or not _MqNMxnzb8e(_ZZswPhKW8.CurrentTarget, _ueIyOvzr84(_ZZswPhKW8.CurrentTarget) or _oFRetILh87(_ZZswPhKW8.CurrentTarget)) then
            _ZZswPhKW8.CurrentTarget = nil
        end
    end
    local _mrSiWRcvbf = _DznvKybf7b()
    if not _ZZswPhKW8.CurrentTarget then
        _ZZswPhKW8.CurrentTarget = _mrSiWRcvbf
        return
    end
    if _mrSiWRcvbf and _mrSiWRcvbf ~= _ZZswPhKW8.CurrentTarget then
        local _PaMydrqQb9 = _oFRetILh87(_LsLxMrpz29.Character)
        local _VmNHbSWK65 = _oFRetILh87(_ZZswPhKW8.CurrentTarget)
        local _kThZwhySbe = _oFRetILh87(_mrSiWRcvbf)
        if _PaMydrqQb9 and _VmNHbSWK65 and _kThZwhySbe then
            local _KHCAWlSN64 = (_PaMydrqQb9.Position - _VmNHbSWK65.Position).Magnitude
            local _KNYVAWpfbd = (_PaMydrqQb9.Position - _kThZwhySbe.Position).Magnitude
            if _KNYVAWpfbd < (_KHCAWlSN64 - 15) then
                _ZZswPhKW8.CurrentTarget = _mrSiWRcvbf
            end
        else
            _ZZswPhKW8.CurrentTarget = _mrSiWRcvbf
        end
    end
end
local _yveVRvxDa6 = nil
local _iMEpnXZQa7 = nil
local _DHnFIFmddd = "Head"
local function _lyDZOPEc42(_eoZklgTd71)
    if not _aGomvVWk2.AimAssist or not _ZZswPhKW8.CurrentTarget then
        _yveVRvxDa6 = nil
        _iMEpnXZQa7 = nil
        return
    end
    local _AOAdjcaI101 = _ZZswPhKW8.CurrentTarget
    if not _AOAdjcaI101 or not _AOAdjcaI101.Parent or not _NMjQFxUwa0(_AOAdjcaI101) then
        _ZZswPhKW8.CurrentTarget = nil
        _yveVRvxDa6 = nil
        _iMEpnXZQa7 = nil
        return
    end
    if not _eWyEhbVC9f(_AOAdjcaI101, 1.25) then
        _ZZswPhKW8.CurrentTarget = nil
        _yveVRvxDa6 = nil
        _iMEpnXZQa7 = nil
        return
    end
    local _aQHWjNXS102 = _ueIyOvzr84(_AOAdjcaI101)
    local _djasABvE106 = _oFRetILh87(_AOAdjcaI101)
    if not _aQHWjNXS102 or not _djasABvE106 then
        return
    end
    local _PVfAEICa66 = _NMcmvokv56.CFrame
    local _qfsvYHWM57 = _PVfAEICa66.Position
    if _iMEpnXZQa7 ~= _AOAdjcaI101 then
        _iMEpnXZQa7 = _AOAdjcaI101
        _yveVRvxDa6 = _PVfAEICa66.Rotation
        _DHnFIFmddd = (math.random() < 0.65) and "Head" or "Torso"
    end
    local _lwIfnfCfee = _aQHWjNXS102
    local _yYXBkTmBc4 = Vector3.zero
    if _aGomvVWk2.TargetPart == "Torso" then
        _lwIfnfCfee = _djasABvE106
        _yYXBkTmBc4 = Vector3.new(0, 0.4, 0)
    elseif _aGomvVWk2.TargetPart == "Random" then
        if _DHnFIFmddd == "Torso" then
            _lwIfnfCfee = _djasABvE106
            _yYXBkTmBc4 = Vector3.new(0, 0.4, 0)
        else
            _lwIfnfCfee = _aQHWjNXS102
        end
    end
    if not _MqNMxnzb8e(_AOAdjcaI101, _lwIfnfCfee) then
        _ZZswPhKW8.CurrentTarget = nil
        _yveVRvxDa6 = nil
        _iMEpnXZQa7 = nil
        return
    end
    local _HNuxcrQB105 = _lwIfnfCfee.Position + _yYXBkTmBc4
    local _LqJmydza11c = _djasABvE106.AssemblyLinearVelocity or _djasABvE106.Velocity
    if _LqJmydza11c then
        local _aytYkXnf95 = Vector3.new(_LqJmydza11c.X, 0, _LqJmydza11c.Z)
        if _aytYkXnf95.Magnitude > 2.5 then
            local _CJwUlgyu6d = (_HNuxcrQB105 - _qfsvYHWM57).Magnitude
            local _fFmhWyfl10b = math.clamp(_CJwUlgyu6d / 1500, 0, 0.12)
            _HNuxcrQB105 = _HNuxcrQB105 + _aytYkXnf95 * _fFmhWyfl10b
        end
    end
    local _PKAayXJQ100 = CFrame.lookAt(_qfsvYHWM57, _HNuxcrQB105)
    local _EWRnfIuz107 = _PKAayXJQ100.Rotation
    local _AlYjqpLof9 = math.clamp(_aGomvVWk2.AimStrength / 100, 0.1, 1)
    local _BeQmnxhx43 = math.clamp(_AlYjqpLof9 * (_eoZklgTd71 * 60), 0.25, 1)
    if not _yveVRvxDa6 then
        _yveVRvxDa6 = _PVfAEICa66.Rotation
    end
    _yveVRvxDa6 = _yveVRvxDa6:Lerp(_EWRnfIuz107, _BeQmnxhx43)
    _NMcmvokv56.CFrame = CFrame.new(_qfsvYHWM57) * _yveVRvxDa6
end
local _FglyUFgx78 = Instance.new("Folder")
_FglyUFgx78.Name = "DX_ESP"
_FglyUFgx78.Parent = _YFyMQItmf
local function _zHMytoVZ63(_fXDgCiFi5c)
    if _ZZswPhKW8.ESP[_fXDgCiFi5c] then return _ZZswPhKW8.ESP[_fXDgCiFi5c] end
    local _YGLOEcbW94 = Instance.new("Folder")
    _YGLOEcbW94.Name = "ESP_" .. _fXDgCiFi5c.Name
    _YGLOEcbW94.Parent = _FglyUFgx78
    local function _SAstrFQT75(_ntIXXJGobc)
        local _EOqAKaQo79 = Instance.new("Frame")
        _EOqAKaQo79.Name = _ntIXXJGobc
        _EOqAKaQo79.BackgroundColor3 = _bgAoJqbe1.accent
        _EOqAKaQo79.BorderSizePixel = 0
        _EOqAKaQo79.Visible = false
        _EOqAKaQo79.ZIndex = 20
        _EOqAKaQo79.Parent = _YGLOEcbW94
        return _EOqAKaQo79
    end
    local _beSdRlOc111 = _SAstrFQT75("BoxTop")
    local _xQluSQKq4e = _SAstrFQT75("BoxBottom")
    local _bVZBDwDoaa = _SAstrFQT75("BoxLeft")
    local _OrIWzoFve1 = _SAstrFQT75("BoxRight")
    local _bXOTLVrt97 = Instance.new("Frame")
    _bXOTLVrt97.Name = "HealthBG"
    _bXOTLVrt97.BackgroundColor3 = Color3.fromRGB(25,25,25)
    _bXOTLVrt97.BorderSizePixel = 0
    _bXOTLVrt97.Visible = false
    _bXOTLVrt97.ZIndex = 20
    _bXOTLVrt97.Parent = _YGLOEcbW94
    local _nsoNCadO98 = Instance.new("Frame")
    _nsoNCadO98.Name = "HealthFill"
    _nsoNCadO98.BackgroundColor3 = _bgAoJqbe1.online
    _nsoNCadO98.BorderSizePixel = 0
    _nsoNCadO98.Visible = false
    _nsoNCadO98.ZIndex = 21
    _nsoNCadO98.Parent = _bXOTLVrt97
    local _hIVPNZFv6c = Instance.new("TextLabel")
    _hIVPNZFv6c.Name = "Info"
    _hIVPNZFv6c.BackgroundTransparency = 1
    _hIVPNZFv6c.Font = Enum.Font.GothamBold
    _hIVPNZFv6c.TextSize = 10
    _hIVPNZFv6c.TextColor3 = Color3.new(1,1,1)
    _hIVPNZFv6c.TextStrokeTransparency = 0.3
    _hIVPNZFv6c.Visible = false
    _hIVPNZFv6c.ZIndex = 22
    _hIVPNZFv6c.Parent = _YGLOEcbW94
    local _ELGpCBMq113 = Instance.new("Frame")
    _ELGpCBMq113.Name = "TracerGlow"
    _ELGpCBMq113.AnchorPoint = Vector2.new(0.5,0.5)
    _ELGpCBMq113.BackgroundColor3 = _bgAoJqbe1.accent
    _ELGpCBMq113.BackgroundTransparency = 0.78
    _ELGpCBMq113.BorderSizePixel = 0
    _ELGpCBMq113.Visible = false
    _ELGpCBMq113.ZIndex = 18
    _ELGpCBMq113.Parent = _YGLOEcbW94
    local _bJFDHfrs112 = Instance.new("Frame")
    _bJFDHfrs112.Name = "Tracer"
    _bJFDHfrs112.AnchorPoint = Vector2.new(0.5,0.5)
    _bJFDHfrs112.BackgroundColor3 = _bgAoJqbe1.accent
    _bJFDHfrs112.BorderSizePixel = 0
    _bJFDHfrs112.Visible = false
    _bJFDHfrs112.ZIndex = 19
    _bJFDHfrs112.Parent = _YGLOEcbW94
    local _UofhsBOI8a = Instance.new("UIGradient")
    _UofhsBOI8a.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(0.3, _bgAoJqbe1.accent),
        ColorSequenceKeypoint.new(1, _bgAoJqbe1.accent2),
    })
    _UofhsBOI8a.Parent = _bJFDHfrs112
    _ZZswPhKW8.ESP[_fXDgCiFi5c] = {
        _YGLOEcbW94=_YGLOEcbW94, _beSdRlOc111=_beSdRlOc111, _xQluSQKq4e=_xQluSQKq4e, _bVZBDwDoaa=_bVZBDwDoaa, _OrIWzoFve1=_OrIWzoFve1,
        _bXOTLVrt97=_bXOTLVrt97, _nsoNCadO98=_nsoNCadO98, _ZvxPNJyp2b=_hIVPNZFv6c,
        _bJFDHfrs112=_bJFDHfrs112, _ELGpCBMq113=_ELGpCBMq113
    }
    _YGLOEcbW94.Destroying:Connect(function()
        if _ZZswPhKW8.ESP[_fXDgCiFi5c] and _ZZswPhKW8.ESP[_fXDgCiFi5c]._YGLOEcbW94 == _YGLOEcbW94 then
            _ZZswPhKW8.ESP[_fXDgCiFi5c] = nil
        end
    end)
    return _ZZswPhKW8.ESP[_fXDgCiFi5c]
end
local function _FIyFkIQidf(_fXDgCiFi5c)
    local _xMFhmDYM67 = _ZZswPhKW8.ESP[_fXDgCiFi5c]
    if _xMFhmDYM67 and _xMFhmDYM67._YGLOEcbW94 then
        _xMFhmDYM67._YGLOEcbW94:Destroy()
    end
    _ZZswPhKW8.ESP[_fXDgCiFi5c] = nil
end
local function _HxEZMJZTf0(_ldcKLrMn81, _PYHkbzQU82, _KWKMaMqd10e, _pmgglyEQ10a)
	local _kiGPwZeN69 = _KWKMaMqd10e - _PYHkbzQU82
	local _NeoTWjmQac = _kiGPwZeN69.Magnitude
	if _NeoTWjmQac < 1 then
		_ldcKLrMn81.Visible = false
		return
	end
	_ldcKLrMn81.Position = UDim2.fromOffset((_PYHkbzQU82.X + _KWKMaMqd10e.X) * 0.5, (_PYHkbzQU82.Y + _KWKMaMqd10e.Y) * 0.5)
	_ldcKLrMn81.Size = UDim2.fromOffset(_NeoTWjmQac, _pmgglyEQ10a)
	_ldcKLrMn81.Rotation = math.deg(math.atan2(_kiGPwZeN69.Y, _kiGPwZeN69.X))
	_ldcKLrMn81.Visible = true
end
local function _dVmLbjHh116()
    if not _aGomvVWk2.PlayerESP then
        for _fXDgCiFi5c in pairs(_ZZswPhKW8.ESP) do _FIyFkIQidf(_fXDgCiFi5c) end
        return
    end
    local _bCdzhPCZ37 = {}
    local _TJbfkEDE11e = _NMcmvokv56.ViewportSize
    local _pexbBuXQeb = Vector2.new(_TJbfkEDE11e.X * 0.5, _TJbfkEDE11e.Y - 14)
    for _, _fXDgCiFi5c in ipairs(_ENSQLaFM83()) do
        local _JkrLlnxU8f = _ueIyOvzr84(_fXDgCiFi5c)
        local _tcZngWQNe3 = _oFRetILh87(_fXDgCiFi5c)
        if not _JkrLlnxU8f or not _tcZngWQNe3 then continue end
        _bCdzhPCZ37[_fXDgCiFi5c] = true
        local _JCAPxiBW74 = _zHMytoVZ63(_fXDgCiFi5c)
        local _yKUNJMoi90, headOn = _NMcmvokv56:WorldToViewportPoint(_JkrLlnxU8f.Position + Vector3.new(0,0.35,0))
        local _smXgtgTne4, rootOn = _NMcmvokv56:WorldToViewportPoint(_tcZngWQNe3.Position - Vector3.new(0,2.8,0))
        local _OXKZQyif11f = headOn and rootOn and _yKUNJMoi90.Z > 0 and _smXgtgTne4.Z > 0
        if not _OXKZQyif11f then
            _JCAPxiBW74._beSdRlOc111.Visible=false; _JCAPxiBW74._xQluSQKq4e.Visible=false; _JCAPxiBW74._bVZBDwDoaa.Visible=false; _JCAPxiBW74._OrIWzoFve1.Visible=false
            _JCAPxiBW74._bXOTLVrt97.Visible=false; _JCAPxiBW74._nsoNCadO98.Visible=false; _JCAPxiBW74._ZvxPNJyp2b.Visible=false
            _JCAPxiBW74._bJFDHfrs112.Visible=false; _JCAPxiBW74._ELGpCBMq113.Visible=false
            continue
        end
        local _RDmZZdgR92 = math._YCbtXVYSb2(math.abs(_smXgtgTne4.Y-_yKUNJMoi90.Y), 24)
        local _JtGvzfce123 = math._YCbtXVYSb2(_RDmZZdgR92*0.55, 24)
        local _VuInPXXK126 = _yKUNJMoi90.X-_JtGvzfce123/2
        local _lhhikECs127 = math._IsLTiCJjb5(_yKUNJMoi90.Y,_smXgtgTne4.Y)
        local _MCkgkydj4f = _ZZswPhKW8.CurrentTarget == _fXDgCiFi5c and _bgAoJqbe1.yellow or _bgAoJqbe1.accent
        for _, _EOqAKaQo79 in ipairs({_JCAPxiBW74._beSdRlOc111,_JCAPxiBW74._xQluSQKq4e,_JCAPxiBW74._bVZBDwDoaa,_JCAPxiBW74._OrIWzoFve1}) do
            _EOqAKaQo79.BackgroundColor3=_MCkgkydj4f
            _EOqAKaQo79.Visible=_aGomvVWk2.EspBox
        end
        _JCAPxiBW74._beSdRlOc111.Position=UDim2.fromOffset(_VuInPXXK126,_lhhikECs127)
        _JCAPxiBW74._beSdRlOc111.Size=UDim2.fromOffset(_JtGvzfce123,2)
        _JCAPxiBW74._xQluSQKq4e.Position=UDim2.fromOffset(_VuInPXXK126,_lhhikECs127+_RDmZZdgR92-2)
        _JCAPxiBW74._xQluSQKq4e.Size=UDim2.fromOffset(_JtGvzfce123,2)
        _JCAPxiBW74._bVZBDwDoaa.Position=UDim2.fromOffset(_VuInPXXK126,_lhhikECs127)
        _JCAPxiBW74._bVZBDwDoaa.Size=UDim2.fromOffset(2,_RDmZZdgR92)
        _JCAPxiBW74._OrIWzoFve1.Position=UDim2.fromOffset(_VuInPXXK126+_JtGvzfce123-2,_lhhikECs127)
        _JCAPxiBW74._OrIWzoFve1.Size=UDim2.fromOffset(2,_RDmZZdgR92)
        local _FbuejvcQ76=Vector2.new(_VuInPXXK126+_JtGvzfce123/2,_lhhikECs127+_RDmZZdgR92)
        local _kiGPwZeN69=_FbuejvcQ76-_pexbBuXQeb
        local _CYShPbUZab=_kiGPwZeN69.Magnitude
        if _aGomvVWk2.EspLine and _CYShPbUZab>1 then
            local _ErQvSDFwb4=(_pexbBuXQeb+_FbuejvcQ76)*0.5
            local _oNTVDmpY44=math.deg(math.atan2(_kiGPwZeN69.Y,_kiGPwZeN69.X))
            _JCAPxiBW74._bJFDHfrs112.Position=UDim2.fromOffset(_ErQvSDFwb4.X,_ErQvSDFwb4.Y)
            _JCAPxiBW74._bJFDHfrs112.Size=UDim2.fromOffset(_CYShPbUZab,_ZZswPhKW8.CurrentTarget==_fXDgCiFi5c and 2.5 or 1.5)
            _JCAPxiBW74._bJFDHfrs112.Rotation=_oNTVDmpY44
            _JCAPxiBW74._bJFDHfrs112.BackgroundColor3=_MCkgkydj4f
            _JCAPxiBW74._bJFDHfrs112.Visible=true
            _JCAPxiBW74._ELGpCBMq113.Position=_JCAPxiBW74._bJFDHfrs112.Position
            _JCAPxiBW74._ELGpCBMq113.Size=UDim2.fromOffset(_CYShPbUZab,_ZZswPhKW8.CurrentTarget==_fXDgCiFi5c and 8 or 5)
            _JCAPxiBW74._ELGpCBMq113.Rotation=_oNTVDmpY44
            _JCAPxiBW74._ELGpCBMq113.Visible=true
        else
            _JCAPxiBW74._bJFDHfrs112.Visible=false
            _JCAPxiBW74._ELGpCBMq113.Visible=false
        end
        local _vzNRxahj91=_dNBkUAqH85(_fXDgCiFi5c)
        local _ZdmMKYKb9a=_MAwFcRrl86(_fXDgCiFi5c)
        local _rPqkxKYQb3=(_ZdmMKYKb9a and _ZdmMKYKb9a.MaxHealth) or 100
        local _xcUxpmJSd1=math.clamp(_vzNRxahj91/math._YCbtXVYSb2(_rPqkxKYQb3,1),0,1)
        _JCAPxiBW74._bXOTLVrt97.Position=UDim2.fromOffset(_VuInPXXK126,_lhhikECs127+_RDmZZdgR92+3)
        _JCAPxiBW74._bXOTLVrt97.Size=UDim2.fromOffset(_JtGvzfce123,4)
        _JCAPxiBW74._bXOTLVrt97.Visible=_aGomvVWk2.EspHealthBar
        _JCAPxiBW74._nsoNCadO98.Size=UDim2.fromScale(_xcUxpmJSd1,1)
        _JCAPxiBW74._nsoNCadO98.BackgroundColor3=_xcUxpmJSd1>0.5 and _bgAoJqbe1.online or (_xcUxpmJSd1>0.25 and Color3.fromRGB(255,200,30) or _bgAoJqbe1.accent)
        _JCAPxiBW74._nsoNCadO98.Visible=_aGomvVWk2.EspHealthBar and _xcUxpmJSd1>0
        local _PaMydrqQb9=_oFRetILh87(_LsLxMrpz29.Character)
        local _CJwUlgyu6d=_PaMydrqQb9 and math.floor((_PaMydrqQb9.Position-_tcZngWQNe3.Position).Magnitude) or 0
        if _aGomvVWk2.EspDistance or _aGomvVWk2.EspHealthBar then
            local _YrCHmvGSd0={}
            if _aGomvVWk2.EspHealthBar then table.insert(_YrCHmvGSd0,tostring(math.ceil(_vzNRxahj91)).." HP") end
            if _aGomvVWk2.EspDistance then table.insert(_YrCHmvGSd0,tostring(_CJwUlgyu6d).." m") end
            _JCAPxiBW74._ZvxPNJyp2b.Text=table.concat(_YrCHmvGSd0,"  •  ")
            _JCAPxiBW74._ZvxPNJyp2b.TextColor3=_ZZswPhKW8.CurrentTarget==_fXDgCiFi5c and _bgAoJqbe1.yellow or _bgAoJqbe1._bRXFEjbV109
            _JCAPxiBW74._ZvxPNJyp2b.Position=UDim2.fromOffset(_VuInPXXK126-20,_lhhikECs127+_RDmZZdgR92+(_aGomvVWk2.EspHealthBar and 8 or 2))
            _JCAPxiBW74._ZvxPNJyp2b.Size=UDim2.fromOffset(_JtGvzfce123+40,14)
            _JCAPxiBW74._ZvxPNJyp2b.Visible=true
        else
            _JCAPxiBW74._ZvxPNJyp2b.Visible=false
        end
    end
    for _fXDgCiFi5c in pairs(_ZZswPhKW8.ESP) do
        if not _bCdzhPCZ37[_fXDgCiFi5c] or not _fXDgCiFi5c.Parent or not _NMjQFxUwa0(_fXDgCiFi5c) then
            _FIyFkIQidf(_fXDgCiFi5c)
        end
    end
end
_louskFdIb.JumpRequest:Connect(function()
	if not _aGomvVWk2.InfiniteJump then return end
	local _fXDgCiFi5c = _LsLxMrpz29.Character
	local _ZdmMKYKb9a = _fXDgCiFi5c and _fXDgCiFi5c:FindFirstChildOfClass("Humanoid")
	if _ZdmMKYKb9a and _ZdmMKYKb9a.Health > 0 then
		_ZdmMKYKb9a:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
local function _cSIXVJet117()
	local _fXDgCiFi5c = _LsLxMrpz29.Character
	local _ZdmMKYKb9a = _fXDgCiFi5c and _fXDgCiFi5c:FindFirstChildOfClass("Humanoid")
	if _ZdmMKYKb9a and _ZdmMKYKb9a.Health > 0 then
		_ZdmMKYKb9a.WalkSpeed = _aGomvVWk2.WalkSpeed
		_ZdmMKYKb9a.JumpPower = _aGomvVWk2.JumpPower
	end
	if _NMcmvokv56 and _NMcmvokv56.FieldOfView ~= _aGomvVWk2.FieldOfView then
		_NMcmvokv56.FieldOfView = _aGomvVWk2.FieldOfView
	end
	if _aGomvVWk2.FullBright then
		_eMuonNlR4.Brightness = 2
		_eMuonNlR4.ClockTime = 14
		_eMuonNlR4.FogEnd = 100000
		_eMuonNlR4.GlobalShadows = false
	else
		_eMuonNlR4.Brightness = _ZZswPhKW8.OriginalLighting.Brightness
		_eMuonNlR4.ClockTime = _ZZswPhKW8.OriginalLighting.ClockTime
		_eMuonNlR4.FogEnd = _ZZswPhKW8.OriginalLighting.FogEnd
		_eMuonNlR4.GlobalShadows = _ZZswPhKW8.OriginalLighting.GlobalShadows
	end
end
local _TRgIGUUQd2 = _HAnRDzCCb1("Frame", {
	Name = "PerformanceHUD",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -16, 0, 52),
	Size = UDim2.fromOffset(135, 26),
	BackgroundColor3 = _bgAoJqbe1._DirbPpind,
	BackgroundTransparency = 0.15,
	BorderSizePixel = 0,
	Visible = _aGomvVWk2.ShowPerformanceOverlay,
	ZIndex = 30,
}, _YFyMQItmf)
_ETYaLHUCe6(_TRgIGUUQd2, 6)
_HAnRDzCCb1("UIStroke", {
	Color = _bgAoJqbe1.accent,
	Thickness = 1,
	Transparency = 0.65,
}, _TRgIGUUQd2)
local _wiumnyxqd3 = _HAnRDzCCb1("TextLabel", {
	Size = UDim2.fromScale(1,1),
	BackgroundTransparency = 1,
	Text = "FPS 60  |  Ping 0ms",
	TextColor3 = _bgAoJqbe1._bRXFEjbV109,
	Font = Enum.Font.GothamBold,
	TextSize = 10,
}, _TRgIGUUQd2)
_sJOQUaZB39(_TRgIGUUQd2, _TRgIGUUQd2)
local _VLubFTur0 = 50
local _bNxEshiW2f = _HAnRDzCCb1("TextButton", {
	Size = UDim2.fromOffset(_VLubFTur0, _VLubFTur0),
	Position = UDim2.fromOffset(16, math.floor(_AsyFDkOk121.Y / 2 - _VLubFTur0 / 2)),
	BackgroundColor3 = _bgAoJqbe1.bg,
	Text = "DX",
	Font = Enum.Font.GothamBlack,
	TextSize = 19,
	TextColor3 = Color3.fromRGB(255, 70, 95),
	AutoButtonColor = false,
}, _YFyMQItmf)
_ETYaLHUCe6(_bNxEshiW2f, _VLubFTur0 / 2)
local _UgWemzuz54 = _HAnRDzCCb1("UIStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 2.5,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, _bNxEshiW2f)
local _ZpSlJnnQ2e = _HAnRDzCCb1("UIGradient", {Color = _XLktryQtc0}, _UgWemzuz54)
_HPyzDNGz3d(_bNxEshiW2f, _VLubFTur0 / 2, {
	{grow = 12, thick = 6, trans = 0.85},
	{grow = 5, thick = 3, trans = 0.65},
})
local _jKcNtTPh53 = _HAnRDzCCb1("UIScale", {Scale = 1}, _bNxEshiW2f)
_bNxEshiW2f.InputBegan:Connect(function(_LTXVxIsb9b)
	if _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseButton1
		or _LTXVxIsb9b.UserInputType == Enum.UserInputType.Touch then
		_IHEDeLBOa:Create(_jKcNtTPh53, TweenInfo.new(0.1), {Scale = 0.88}):Play()
	end
end)
_bNxEshiW2f.InputEnded:Connect(function(_LTXVxIsb9b)
	if _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseButton1
		or _LTXVxIsb9b.UserInputType == Enum.UserInputType.Touch then
		_IHEDeLBOa:Create(_jKcNtTPh53, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Scale = 1}):Play()
	end
end)
local function _pxYPHznxa3()
	local _rSOtyoyK7 = _YFyMQItmf.AbsoluteSize
	if _rSOtyoyK7.X == 0 or _rSOtyoyK7.Y == 0 then return end
	local _JXDQJxspcb = _TRgIGUUQd2.Position
	local _VuInPXXK126 = _JXDQJxspcb.X.Scale * _rSOtyoyK7.X + _JXDQJxspcb.X.Offset
	local _lhhikECs127 = _JXDQJxspcb.Y.Scale * _rSOtyoyK7.Y + _JXDQJxspcb.Y.Offset
	local _qpNkxwdn122 = _TRgIGUUQd2.AbsoluteSize.X
	local _hItGpLql8c = _TRgIGUUQd2.AbsoluteSize.Y
	_TRgIGUUQd2.Position = UDim2.fromOffset(
		math.clamp(_VuInPXXK126, 8, math._YCbtXVYSb2(8, _rSOtyoyK7.X - _qpNkxwdn122 - 8)),
		math.clamp(_lhhikECs127, 8, math._YCbtXVYSb2(8, _rSOtyoyK7.Y - _hItGpLql8c - 8))
	)
end
local function _BbGGtyhW11()
	local _rSOtyoyK7 = _YFyMQItmf.AbsoluteSize
	if _rSOtyoyK7.X == 0 or _rSOtyoyK7.Y == 0 then return end
	local _JXDQJxspcb = _bNxEshiW2f.Position
	local _VuInPXXK126 = _JXDQJxspcb.X.Scale * _rSOtyoyK7.X + _JXDQJxspcb.X.Offset
	local _lhhikECs127 = _JXDQJxspcb.Y.Scale * _rSOtyoyK7.Y + _JXDQJxspcb.Y.Offset
	local _eSjRlptGc1 = math.clamp(_VuInPXXK126, 8, math._YCbtXVYSb2(8, _rSOtyoyK7.X - _VLubFTur0 - 8))
	local _NgCxEYbuc2 = math.clamp(_lhhikECs127, 8, math._YCbtXVYSb2(8, _rSOtyoyK7.Y - _VLubFTur0 - 8))
	_bNxEshiW2f.Position = UDim2.fromOffset(_eSjRlptGc1, _NgCxEYbuc2)
end
_louskFdIb.InputEnded:Connect(function(_LTXVxIsb9b)
	if _LTXVxIsb9b.UserInputType == Enum.UserInputType.MouseButton1
		or _LTXVxIsb9b.UserInputType == Enum.UserInputType.Touch then
		_BbGGtyhW11()
	end
end)
_YFyMQItmf:GetPropertyChangedSignal("AbsoluteSize"):Connect(_BbGGtyhW11)
_YFyMQItmf:GetPropertyChangedSignal("AbsoluteSize"):Connect(_pxYPHznxa3)
task.defer(_BbGGtyhW11)
task.defer(_pxYPHznxa3)
local _TNSjmZPJ1d = true
local _gDtxuOeYe = 0
local function _DfHNhtYQ1c(_mQsSIrIa11a)
	_TNSjmZPJ1d = _mQsSIrIa11a
	_gDtxuOeYe += 1
	local _PjJrLFygb8 = _gDtxuOeYe
	if _mQsSIrIa11a then
		_NDkRovhZ16.Visible = true
		_IHEDeLBOa:Create(_WorIltuL1a, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()
		_IHEDeLBOa:Create(_KJAWzDqL35, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			GroupTransparency = 0
		}):Play()
		_IHEDeLBOa:Create(_LVBtPLtv38, TweenInfo.new(0.25), {Transparency = 0}):Play()
	else
		local _KokZaAPj9d = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		_IHEDeLBOa:Create(_WorIltuL1a, _KokZaAPj9d, {Scale = 0.88}):Play()
		_IHEDeLBOa:Create(_LVBtPLtv38, _KokZaAPj9d, {Transparency = 1}):Play()
		local _RcFFlolB114 = _IHEDeLBOa:Create(_KJAWzDqL35, _KokZaAPj9d, {GroupTransparency = 1})
		_RcFFlolB114:Play()
		_RcFFlolB114.Completed:Connect(function()
			if _gDtxuOeYe == _PjJrLFygb8 and not _TNSjmZPJ1d then
				_NDkRovhZ16.Visible = false
			end
		end)
	end
end
_WorIltuL1a.Scale = 0.88
_KJAWzDqL35.GroupTransparency = 1
_LVBtPLtv38.Transparency = 1
_DfHNhtYQ1c(true)
_sJOQUaZB39(_bNxEshiW2f, _bNxEshiW2f, function()
	_DfHNhtYQ1c(not _TNSjmZPJ1d)
end)
_yqMLlkzh1b.MouseButton1Click:Connect(function()
	_DfHNhtYQ1c(false)
end)
_louskFdIb.InputBegan:Connect(function(_UjFkliUw9e, _bnIeZUVld7)
	if _bnIeZUVld7 then return end
	if _UjFkliUw9e.KeyCode == Enum.KeyCode.RightShift or _UjFkliUw9e.KeyCode == Enum.KeyCode.Insert then
		_DfHNhtYQ1c(not _TNSjmZPJ1d)
	end
end)
local _iyBAQoiK7f = 0
local _FprnNfHy80 = os.clock()
local _NrwQSbRk7e = 60
_hYDtquDg6.RenderStepped:Connect(function(_eoZklgTd71)
	local _ICCBxncCfd = os.clock()
	local _jntVLEGke5 = (_ICCBxncCfd * 90) % 360
	_UlMoLUJK36.Rotation = _jntVLEGke5
	_ZpSlJnnQ2e.Rotation = _jntVLEGke5
	_OQbZKQZq6e.BackgroundTransparency = 0.45 * (math.sin(_ICCBxncCfd * 3) * 0.5 + 0.5)
	if _cdXmsqvb2c.model and _NDkRovhZ16.Visible and _SBSYAjqZ18["Overview"]._lWpVJWUJ21.Visible then
		_cdXmsqvb2c._oNTVDmpY44 = (_cdXmsqvb2c._oNTVDmpY44 + _eoZklgTd71 * 0.9) % (math.pi * 2)
		_cdXmsqvb2c.model:PivotTo(CFrame.Angles(0, _cdXmsqvb2c._oNTVDmpY44, 0))
	end
	if _aGomvVWk2.ShowFov and _aGomvVWk2.AimAssist then
		local _kYXOUosy5b = Vector2.new(_YFyMQItmf.AbsoluteSize.X * 0.5, _YFyMQItmf.AbsoluteSize.Y * 0.5)
		_GVrVDgJH7d.Position = UDim2.fromOffset(_kYXOUosy5b.X, _kYXOUosy5b.Y)
		_GVrVDgJH7d.Size = UDim2.fromOffset(_aGomvVWk2.FovRadius * 2, _aGomvVWk2.FovRadius * 2)
		_GVrVDgJH7d.Visible = true
	else
		_GVrVDgJH7d.Visible = false
	end
	_dVmLbjHh116()
end)
pcall(function()
    _hYDtquDg6:UnbindFromRenderStep("DX_AimAssist")
end)
_hYDtquDg6:BindToRenderStep("DX_AimAssist", Enum.RenderPriority.Camera.Value + 1, function(_eoZklgTd71)
    local _AsyFDkOk121 = _NMcmvokv56.ViewportSize
    local _ZQNIpsII7c = _aGomvVWk2.FovRadius * 2
    _GVrVDgJH7d.Size = UDim2.fromOffset(_ZQNIpsII7c, _ZQNIpsII7c)
    _GVrVDgJH7d.Position = UDim2.fromOffset(_AsyFDkOk121.X * 0.5, _AsyFDkOk121.Y * 0.5)
    _GVrVDgJH7d.Visible = _aGomvVWk2.ShowFov
    if _aGomvVWk2.AimAssist then
        _yGaZhVql118()
        _lyDZOPEc42(_eoZklgTd71)
    else
        _ZZswPhKW8.CurrentTarget = nil
    end
end)
_hYDtquDg6.Heartbeat:Connect(function()
	_cSIXVJet117()
	_iyBAQoiK7f += 1
	if os.clock() - _FprnNfHy80 >= 1 then
		_NrwQSbRk7e = _iyBAQoiK7f
		_iyBAQoiK7f = 0
		_FprnNfHy80 = os.clock()
	end
	local _nuEXdCjGd5 = 0
	pcall(function()
		_nuEXdCjGd5 = math.floor(_LsLxMrpz29:GetNetworkPing() * 1000)
	end)
	_TRgIGUUQd2.Visible = _aGomvVWk2.ShowPerformanceOverlay
	_wiumnyxqd3.Text = string.format("FPS %d  |  Ping %dms", _NrwQSbRk7e, _nuEXdCjGd5)
end)
_aluMQSrN5.PlayerRemoving:Connect(function(_JXDQJxspcb)
	if _JXDQJxspcb.Character then
		_FIyFkIQidf(_JXDQJxspcb.Character)
	end
end)
_LsLxMrpz29.CharacterAdded:Connect(function(_fXDgCiFi5c)
	_fXDgCiFi5c:WaitForChild("Humanoid", 5)
	task.wait()
	_cSIXVJet117()
end)
print("[DX Panel] Single-script DX.txt features initialized.")
