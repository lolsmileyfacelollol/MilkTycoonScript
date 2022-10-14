local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Singularity5490/rbimgui-2/main/rbimgui-2.lua"))()
local window = ui.new({text="Milk Tycoon Fucker - Cj#9089"})
local TrollTab = window.new({text="Troll"})
local mainTab = window.new({text="Main"})
local Dropdown = TrollTab.new("Dropdown",{text="Player to shower"})
local pickupMilk = mainTab.new("Button", {text="Quick-Pickup"})
local ShowerInMilk = TrollTab.new("Button", {text="Give milky shower"})
local TpObbyWin = mainTab.new("Button", {text="Tp 2 obby win"})
local autoPickupToggle = mainTab.new("Switch", {text="Auto Pickup"})
local flyToggle = mainTab.new("Switch", {text="fly"})
local FlySpeedSlider = mainTab.new("Slider", {text="Fly Speed", min=1, max=99, value=1})
local Rejoin = mainTab.new("Button", {text="Rejoin Server (will need to re-execute script after)"})
local mouse = Players.LocalPlayer:GetMouse()
local Playerlist = {}
local ChosenMilkPlr = Players.LocalPlayer.Name
local PlayersTycoon 
Players.PlayerAdded:Connect(function(plr)
	if not table.find(Playerlist, plr.Name) then
		table.insert(Playerlist, plr.Name)
		Dropdown.new(plr.Name)
	end
end)

for i, v in pairs(Players:GetChildren()) do
	if not table.find(Playerlist, v.Name) then
		table.insert(Playerlist, v.Name)
		Dropdown.new(v.Name)
	end
end

Dropdown.event:Connect(function(v)
	ChosenMilkPlr = v
end)

for i,v in pairs(game:GetService("Workspace").Tycoons:GetChildren()) do
	if v.Owner.Value == Players.LocalPlayer.Name then
		PlayersTycoon = v
		break
	end
end
FLYING = false
function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and Players.LocalPlayer.Character.HumanoidRootPart and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until mouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = Players.LocalPlayer.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and FlySpeedSlider.value)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and FlySpeedSlider.value)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and FlySpeedSlider.value)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and FlySpeedSlider.value)
		elseif KEY:lower() == 'e' then
			CONTROL.Q = (vfly and FlySpeedSlider.value)*2
		elseif KEY:lower() == 'q' then
			CONTROL.E = -(vfly and FlySpeedSlider.value)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end
function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end
flyToggle.event:Connect(function(v)
	if v then
		Players.LocalPlayer.Character:SetPrimaryPartCFrame(Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,60))
		sFLY(true)
	else
		NOFLY()
	end
end)
function PICKUPMILK()
	for i,v in pairs(PlayersTycoon.Drops:GetChildren()) do
		task.wait()

		if v.Name == "Cow5" then
			v.Part.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame  * CFrame.new(0,1,0)
			v.HitBox.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame  * CFrame.new(0,1,0)
		end

		if v:FindFirstChildOfClass("Part") then
			local vp = v:FindFirstChildOfClass("Part")
			vp.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame  * CFrame.new(0,1,0)
		end
	end
end
function SHOWERMILK()
	local targ = Players[ChosenMilkPlr].Character.HumanoidRootPart
	for i,v in pairs(PlayersTycoon.Drops:GetChildren()) do
		task.wait()
		if not targ then return end
		if v.Name == "Cow5" then
			v.Part.CFrame = targ.CFrame  * CFrame.new(math.random(-5,5),10,math.random(-5,5))
			v.HitBox.CFrame = targ.CFrame  * CFrame.new(math.random(-5,5),10,math.random(-5,5))
		end

		if v:FindFirstChildOfClass("Part") then
			local vp = v:FindFirstChildOfClass("Part")
			vp.CFrame = targ.CFrame  * CFrame.new(math.random(-5,5),10,math.random(-5,5))
		end
	end
end

local function TpArea(part)
	for i = 0,1,0.1 do
		task.wait()
		Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame:Lerp(part.CFrame * CFrame.new(0,5,0), i)
	end
end

autoPickupToggle.event:Connect(function(v)
	if v then
		PICKUPMILK()		
	end
end)		
TpObbyWin.event:Connect(function()
	TpArea(game:GetService("Workspace").Obby.RewardPart)
end)
ShowerInMilk.event:Connect(function()
	SHOWERMILK()
end)
Rejoin.event:Connect(function()
	    local ts = game:GetService("TeleportService")
            ts:Teleport(game.PlaceId, Players.LocalPlayer)
end)
pickupMilk.event:Connect(function()
	PICKUPMILK()
end)

if PlayersTycoon.Drops then
	PlayersTycoon.Drops.ChildAdded:Connect(function()
		if autoPickupToggle.on then
			PICKUPMILK()
		end
	end)
end
