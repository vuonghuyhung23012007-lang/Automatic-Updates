local LoadingTime = tick()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vuonghuyhung23012007-lang/Automatic-Updates/refs/heads/main/Src"))()
local Window = Library:CreateWindow({Credit = "pindummy"})

-- ========== EXTRACTED FUNCTIONS ==========

local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local cooldownfastattack = tick()

function getAllBladeHits(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i=1,#Enemies do 
		local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end

function CurrentWeapon()
	local ac = CombatFrameworkR.activeController
	local ret = ac.blades[1]
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	pcall(function()
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
	end)
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	return ret
end

function AttackFunction()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHits(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
				AcAttack8 = math.floor(NumberAc12 / AcAttack9)
				AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Tool") and ac.blades and ac.blades[1] then
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
				end
			end
		end
	end
end

function EquipWeapon(Tool)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool)
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid)
		end
	end)
end

function toTarget(targetPos)
	local Distance = (targetPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	local Speed = Distance < 1000 and 315 or 300
	
	local tween_s = game:GetService("TweenService")
	local info = TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear)
	local tween = tween_s:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = targetPos})
	tween:Play()
	return tween
end

function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		return (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350
	end
end

-- ========== SETTINGS ==========

_G.Settings = {
	AutoFarm = false,
	SelectWeapon = "Combat",
	Distance = 20,
	UseSkillZ = true,
	UseSkillX = true,
	UseSkillC = true,
	UseSkillV = true,
	FastAttack = true,
	AutoHaki = true
}

-- ========== UI SETUP ==========

local Page1 = Window:AddPage({
	Title = "General",
	Icon = "home",
	Page = {
		Left = {Name = "Farm", Icon = "arrow-big-up"},
		Right = {Name = "Setup", Icon = "file-cog"}
	}
})

Page1:CreateToggle("Left", {
	Title = "Farm Level",
	Desc = "Level Max 2400",
	Value = false,
	Callback = function(vu)
		_G.Settings.AutoFarm = vu
	end
})

Page1:CreateDropdown("Right",{
	Title = "Weapon",
	Desc = "Select Weapon Farm",
	ListDesc = "Select Weapon To Farm",
	Value = "Melee",
	List = {"Melee", "Sword", "Power Fruit"},
	MultiDropdown = false,
	Callback = function(vu)
		_G.Settings.SelectWeapon = vu
	end
})

Page1:CreateSlider("Right",{
	Title = 'Distance',
	Desc = "Setup Distance",
	Min = 1,
	Max = 20,
	Value = 20,
	Callback = function(vu)
		_G.Settings.Distance = vu
	end
})

Page1:CreateLabel("Right", {Title = " - Setting Skill", Desc = "Select Skill To Use Farm"})

Page1:CreateToggle("Right", {Title = "Skill Z", Value = true, Callback = function(vu) _G.Settings.UseSkillZ = vu end})
Page1:CreateToggle("Right", {Title = "Skill X", Value = true, Callback = function(vu) _G.Settings.UseSkillX = vu end})
Page1:CreateToggle("Right", {Title = "Skill C", Value = true, Callback = function(vu) _G.Settings.UseSkillC = vu end})
Page1:CreateToggle("Right", {Title = "Skill V", Value = true, Callback = function(vu) _G.Settings.UseSkillV = vu end})

Page1:CreateButton("Right",{
	Title = "Redeem All Code",
	Desc = "Redeem All Code Need lv 25",
	Secure = false,
	Callback = function()
		pcall(function()
			for i, v in pairs(require(game:GetService("ReplicatedStorage").ModuleScript.CodeList)) do
				if not game:GetService("Players").LocalPlayer.Code:FindFirstChild(i) then
					game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Code"):InvokeServer(i)
				end
			end
		end)
	end
})

-- ========== MAIN LOOP ==========

spawn(function()
	while wait() do
		if _G.Settings.AutoHaki then
			if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
			end
		end
	end
end)

coroutine.wrap(function()
	while task.wait(.1) do
		local ac = CombatFrameworkR.activeController
		if ac and ac.equipped and _G.Settings.FastAttack then
			AttackFunction()
		end
		end
	end)()
