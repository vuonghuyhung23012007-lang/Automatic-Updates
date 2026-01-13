print("https://discord.gg/aUd8umqUKu")
toclipboard("https://discord.gg/aUd8umqUKu")

-- Remove Death and Respawn effects
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
	game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy()
end
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
	game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy()
end

-- Settings Configuration
_G.Settings = {
	Main = {
		["Auto Farm Level"] = false,
		["Fast Auto Farm Level"] = false,
		["Distance Mob Aura"] = 1000,
		["Mob Aura"] = false,
		["Auto New World"] = false,
		["Auto Saber"] = false,
		["Auto Pole"] = false,
		["Auto Buy Ablility"] = false,
		["Auto Third Sea"] = false,
		["Auto Factory"] = false,
		["Auto Factory Hop"] = false,
		["Auto Bartilo Quest"] = false,
		["Auto True Triple Katana"] = false,
		["Auto Rengoku"] = false,
		["Auto Swan Glasses"] = false,
		["Auto Dark Coat"] = false,
		["Auto Ectoplasm"] = false,
		["Auto Buy Legendary Sword"] = false,
		["Auto Buy Enchanment Haki"] = false,
		["Auto Holy Torch"] = false,
		["Auto Buddy Swords"] = false,
		["Auto Farm Boss Hallow"] = false,
		["Auto Rainbow Haki"] = false,
		["Auto Elite Hunter"] = false,
		["Auto Musketeer Hat"] = false,
		["Auto Buddy Sword"] = false,
		["Auto Farm Bone"] = false,
		["Auto Ken-Haki V2"] = false,
		["Auto Cavander"] = false,
		["Auto Yama Sword"] = false,
		["Auto Tushita Sword"] = false,
		["Auto Serpent Bow"] = false,
		["Auto Dark Dagger"] = false,
		["Auto Cake Prince"] = false,
		["Auto Dough V2"] = false,
		["Auto Random Bone"] = false,
		["Auto Fish Tail Sea 1"] = false,
		["Auto Fish Tail Sea 3"] = false,
		["Auto Magma Ore Sea 2"] = false,
		["Auto Magma Ore Sea 1"] = false,
		["Auto Mystic Droplet"] = false,
		["Auto Dragon Scales"] = false,
	},
	FightingStyle = {
		["Auto God Human"] = false,
		["Auto Superhuman"] = false,
		["Auto Electric Claw"] = false,
		["Auto Death Step"] = false,
		["Auto Fully Death Step"] = false,
		["Auto SharkMan Karate"] = false,
		["Auto Fully SharkMan Karate"] = false,
		["Auto Dragon Talon"] = false,
	},
	Boss = {
		["Auto All Boss"] = false,
		["Auto Boss Select"] = false,
		["Select Boss"] = {},
		["Auto Quest"] = false,
	},
	Mastery = {
		["Select Multi Sword"] = {},
		["Farm Mastery SwordList"] = false,
		["Auto Farm Fruit Mastery"] = false,
		["Auto Farm Gun Mastery"] = false,
		["Mob Health (%)"] = 15,
	},
	Configs = {
		["Double Quest"] = false,
		["Bypass TP"] = false,
		["Select Team"] = {"Pirate"},
		["Fast Attack"] = true,
		["Fast Attack Type"] = {"Fast"},
		["Select Weapon"] = {},
		["Auto Haki"] = true,
		["Distance Auto Farm"] = 20,
		["Camera Shaker"] = false,
		["Skill Z"] = true,
		["Skill X"] = true,
		["Skill C"] = true,
		["Skill V"] = true,
		["Show Hitbox"] = false,
		["Bring Mob"] = true,
		["Disabled Damage"] = false,
	},
	Stat = {
		["Enabled Auto Stats"] = false,
		["Auto Stats Kaitun"] = false,
		["Select Stats"] = {"Melee"},
		["Point Select"] = 3,
		["Enabled Auto Redeem Code"] = false,
		["Select Level Redeem Code"] = 1,
	},
	Misc = {
		["No Soru Cooldown"] = false,
		["No Dash Cooldown"] = false,
		["Infinities Geppo"] = false,
		["Infinities Energy"] = false,
		["No Fog"] = false,
		["Wall-TP"] = false,
		["Fly"] = false,
		["Fly Speed"] = 1,
		["Auto Rejoin"] = true,
	},
	Teleport = {
		["Teleport to Sea Beast"] = false,
	},
	Fruits = {
		["Auto Buy Random Fruits"] = false,
		["Auto Store Fruits"] = false,
		["Select Devil Fruits"] = {},
		["Auto Buy Devil Fruits Sniper"] = false,
	},
	Raids = {
		["Auto Raids"] = false,
		["Kill Aura"] = false,
		["Auto Awakened"] = false,
		["Auto Next Place"] = false,
		["Select Raids"] = {},
	},
	Combat = {
		["Fov Size"] = 200,
		["Show Fov"] = false,
		["Aimbot Skill"] = false,
	},
	HUD = {
		["FPS"] = 60,
		["LockFPS"] = true,
		["Boost FPS Windows"] = false,
		['White Screen'] = false,
	},
	ConfigsUI = {
		ColorUI = Color3.fromRGB(255, 0, 127),
	}
}

-- Combat Framework Setup
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
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
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
				end
			end
		end
	end
end

-- Enemy Spawns Setup
local EnemySpawns = Instance.new("Folder",workspace)
EnemySpawns.Name = "EnemySpawns"

for i, v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
	if v:IsA("Part") then
		local EnemySpawnsX2 = v:Clone()
		local result = string.gsub(v.Name, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		EnemySpawnsX2.Name = result4
		EnemySpawnsX2.Parent = workspace.EnemySpawns
		EnemySpawnsX2.Anchored = true
	end
end

for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
	if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
		local EnemySpawnsX2 = v.HumanoidRootPart:Clone()
		local result = string.gsub(v.Name, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		EnemySpawnsX2.Name = result4
		EnemySpawnsX2.Parent = workspace.EnemySpawns
		EnemySpawnsX2.Anchored = true
	end
end

for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
	if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
		local EnemySpawnsX2 = v.HumanoidRootPart:Clone()
		local result = string.gsub(v.Name, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		EnemySpawnsX2.Name = result4
		EnemySpawnsX2.Parent = workspace.EnemySpawns
		EnemySpawnsX2.Anchored = true
	end
end

-- Settings Management
function LoadSettings()
	if readfile and writefile and isfile and isfolder then
		if not isfolder("Silver Hub Premium Scripts") then
			makefolder("Silver Hub Premium Scripts")
		end
		if not isfolder("Silver Hub Premium Scripts/Blox Fruits/") then
			makefolder("Silver Hub Premium Scripts/Blox Fruits/")
		end
		if not isfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
			writefile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(_G.Settings))
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
			for i,v in pairs(Decode) do
				_G.Settings[i] = v
			end
		end
	else
		return warn("Status : Undetected Executor")
	end
end

function SaveSettings()
	if readfile and writefile and isfile and isfolder then
		if not isfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
			LoadSettings()
		else
			local Decode = game:GetService("HttpService"):JSONDecode(readfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
			local Array = {}
			for i,v in pairs(_G.Settings) do
				Array[i] = v
			end
			writefile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(Array))
		end
	else
		return warn("Status : Undetected Executor")
	end
end

LoadSettings()

-- Auto Update
spawn(function()
	while wait() do
		if _G.AutoFarmLevelReal then
			FastAttack = true
		else
			FastAttack = false
		end
	end
end)

-- Quest Check Function
local function QuestCheck()
	local Lvl = game:GetService("Players").LocalPlayer.Data.Level.Value
	if Lvl >= 1 and Lvl <= 9 then
		if tostring(game.Players.LocalPlayer.Team) == "Marines" then
			MobName = "Trainee [Lv. 5]"
			QuestName = "MarineQuest"
			QuestLevel = 1
			Mon = "Trainee"
			NPCPosition = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
		elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
			MobName = "Bandit [Lv. 5]"
			Mon = "Bandit"
			QuestName = "BanditQuest1"
			QuestLevel = 1
			NPCPosition = CFrame.new(1059.99731, 16.9222069, 1549.28162, -0.95466274, 7.29721794e-09, 0.297689587, 1.05190106e-08, 1, 9.22064114e-09, -0.297689587, 1.19340022e-08, -0.95466274)
		end
		return {
			[1] = QuestLevel,
			[2] = NPCPosition,
			[3] = MobName,
			[4] = QuestName,
			[5] = LevelRequire,
			[6] = Mon,
			[7] = MobCFrame
		}
	end
	
	if Lvl >= 210 and Lvl <= 249 then
		MobName = "Dangerous Prisoner [Lv. 210]"
		QuestName = "PrisonerQuest"
		QuestLevel = 2
		Mon = "Dangerous Prisoner"
		NPCPosition = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
		local matchingCFrames = {}
		local result = string.gsub(MobName, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		
		for i,v in pairs(game.workspace.EnemySpawns:GetChildren()) do
			if v.Name == result4 then
				table.insert(matchingCFrames, v.CFrame)
			end
			MobCFrame = matchingCFrames
		end
		return {
			[1] = QuestLevel,
			[2] = NPCPosition,
			[3] = MobName,
			[4] = QuestName,
			[5] = LevelRequire,
			[6] = Mon,
			[7] = MobCFrame
		}
	end
	
	local GuideModule = require(game:GetService("ReplicatedStorage").GuideModule)
	local Quests = require(game:GetService("ReplicatedStorage").Quests)
	for i,v in pairs(GuideModule["Data"]["NPCList"]) do
		for i1,v1 in pairs(v["Levels"]) do
			if Lvl >= v1 then
				if not LevelRequire then
					LevelRequire = 0
				end
				if v1 > LevelRequire then
					NPCPosition = i["CFrame"]
					QuestLevel = i1
					LevelRequire = v1
				end
				if #v["Levels"] == 3 and QuestLevel == 3 then
					NPCPosition = i["CFrame"]
					QuestLevel = 2
					LevelRequire = v["Levels"][2]
				end
			end
		end
	end
	
	if Lvl >= 375 and Lvl <= 399 then
		MobCFrame = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
		if _G.StartFarm and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			return
		end
	end
	
	if Lvl >= 400 and Lvl <= 449 then
		MobCFrame = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
		if _G.StartFarm and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			return
		end
	end
	
	for i,v in pairs(Quests) do
		for i1,v1 in pairs(v) do
			if v1["LevelReq"] == LevelRequire and i ~= "CitizenQuest" then
				QuestName = i
				for i2,v2 in pairs(v1["Task"]) do
					MobName = i2
					Mon = string.split(i2," [Lv. ".. v1["LevelReq"] .. "]")[1]
				end
			end
		end
	end
	
	if QuestName == "MarineQuest2" then
		QuestName = "MarineQuest2"
		QuestLevel = 1
		MobName = "Chief Petty Officer [Lv. 120]"
		Mon = "Chief Petty Officer"
		LevelRequire = 120
	elseif QuestName == "ImpelQuest" then
		QuestName = "PrisonerQuest"
		QuestLevel = 2
		MobName = "Dangerous Prisoner [Lv. 190]"
		Mon = "Dangerous Prisoner"
		LevelRequire = 210
		NPCPosition = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
	elseif QuestName == "SkyExp1Quest" then
		if QuestLevel == 1 then
			NPCPosition = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
		elseif QuestLevel == 2 then
			NPCPosition = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
		end
	elseif QuestName == "Area2Quest" and QuestLevel == 2 then
		QuestName = "Area2Quest"
		QuestLevel = 1
		MobName = "Swan Pirate [Lv. 775]"
		Mon = "Swan Pirate"
		LevelRequire = 775
	end
	
	MobName = MobName:sub(1,#MobName)
	if not MobName:find("Lv") then
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			MonLV = string.match(v.Name, "%d+")
			if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
				MobName = v.Name
			end
		end
	end
	
	if not MobName:find("Lv") then
		for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
			MonLV = string.match(v.Name, "%d+")
			if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
				MobName = v.Name
				Mon = a
			end
		end
	end
	
	local matchingCFrames = {}
	local result = string.gsub(MobName, "Lv. ", "")
	local result2 = string.gsub(result, "[%[%]]", "")
	local result3 = string.gsub(result2, "%d+", "")
	local result4 = string.gsub(result3, "%s+", "")
	
	for i,v in pairs(game.workspace.EnemySpawns:GetChildren()) do
		if v.Name == result4 then
			table.insert(matchingCFrames, v.CFrame)
		end
		MobCFrame = matchingCFrames
	end
	
	return {
		[1] = QuestLevel,
		[2] = NPCPosition,
		[3] = MobName,
		[4] = QuestName,
		[5] = LevelRequire,
		[6] = Mon,
		[7] = MobCFrame,
		[8] = MonQ,
		[9] = MobCFrameNuber
	}
end

-- Bypass Function
function Bypass(Point)
	toposition(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
	wait(1.5)
	_G.StopTween = true
	_G.StertScript = false
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
	game.Players.LocalPlayer.Character.Head:Destroy()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
	wait(.2)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
	wait(.1)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
	wait(.1)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
	wait(0.5)
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(900,900,900)
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
	_G.StopTween = false
	_G.StertScript = false
	_G.Clip = false
	if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
	end
	_G.Clip = false
end

-- ToTarget Function
local function toTarget(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then 
		if tween then tween:Cancel() end 
		repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
		wait(0.2) 
	end

	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 1000 then
		Speed = 315
	elseif Distance >= 1000 then
		Speed = 300
	end

	if _G.Settings.Configs["Bypass TP"] then
		if Distance > 3000 and not AutoFarmMaterial and not _G.Settings.FightingStyle["Auto God Human"] and not _G.Settings.Raids["Auto Raids"] and not (game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice")) and not (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") then
			pcall(function()
				tween:Cancel()
				fkwarp = false

				if game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("SpawnPoint").Value == tostring(GetIsLand(RealTarget)) then 
					wait(.1)
					Com("F_","TeleportToSpawn")
				elseif game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("LastSpawnPoint").Value == tostring(GetIsLand(RealTarget)) then
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					wait(0.1)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
				else
					if game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
						if fkwarp == false then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RealTarget
						end
						fkwarp = true
					end
					wait(.08)
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
					wait(.1)
					Com("F_","SetSpawnPoint")
				end
				wait(0.2)
				return
			end)
		end
	end

	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		tween:Cancel()
	end 

	function tweenfunc:Wait()
		tween.Completed:Wait()
	end 

	return tweenfunc
end

-- Network Functions
function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 350 then 
			return true
		end
		return false
	end
end

spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

local SetCFarme = 1

local function GetIsLand(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end

	local ReturnValue
	local CheckInOut = math.huge;
	if game.Players.LocalPlayer.Team then
		for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do 
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude < CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue = v.Name
			end
		end
		if ReturnValue then
			return ReturnValue
		end 
	end
end

-- Bring Mob Function
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoFarmLevelReal and BringMobFarm then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 400 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Size = Vector3.new(60,60,60)
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						end
					end
				end
			end
		end)
	end
end)

-- Equip/UnEquip Weapon Functions
function EquipWeapon(Tool)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then 
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) 
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
		end
	end)
end

function UnEquipWeapon(Weapon)
	if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
		_G.NotAutoEquip = true
		wait(.5)
		game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
		wait(.1)
		_G.NotAutoEquip = false
	end
end

-- Main Farm Loop
spawn(function()
	while wait() do 
		local MyLevel = game.Players.LocalPlayer.Data.Level.Value
		local QuestC = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
		if _G.AutoFarmLevelReal then
			if QuestC.Visible == true then
				if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
					Bypass(QuestCheck()[2])
				end
				if game:GetService("Workspace").Enemies:FindFirstChild(QuestCheck()[3]) then
					for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v.Name == QuestCheck()[3] then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat task.wait()
									if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestCheck()[6]) then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
									else
										PosMon = v.HumanoidRootPart.CFrame
										v.HumanoidRootPart.Size = Vector3.new(60,60,60)
										v.HumanoidRootPart.CanCollide = false
										v.Humanoid.WalkSpeed = 0
										v.Head.CanCollide = false
										BringMobFarm = true
										EquipWeapon(_G.Settings.Configs["Select Weapon"])
										v.HumanoidRootPart.Transparency = 1
										toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
									end
								until not _G.AutoFarmLevelReal or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
							end
						end
					end
				else
					UnEquipWeapon(_G.Settings.Configs["Select Weapon"])
					toTarget(QuestCheck()[7][SetCFarme] * CFrame.new(0,30,5))
					if (QuestCheck()[7][SetCFarme].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
						if SetCFarme == nil or SetCFarme == '' then
							SetCFarme = 1
						elseif SetCFarme >= #QuestCheck()[7] then
							SetCFarme = 1
						end
						SetCFarme = SetCFarme + 1
						wait(0.5)
					end
				end
			else
				wait(0.5)
				if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == tostring(GetIsLand(QuestCheck()[7][1])) then
					game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", QuestCheck()[4], QuestCheck()[1]) 
					wait(0.5)
					toTarget(QuestCheck()[7][1] * CFrame.new(0,30,20))
				else
					if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
						Bypass(QuestCheck()[2])
					else
						repeat wait() toTarget(QuestCheck()[2]) until (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.StartFarm
					end
					repeat wait() toTarget(QuestCheck()[2]) until (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.StartFarm
					if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
						BringMobFarm = false
						wait(0.2)
						game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", QuestCheck()[4], QuestCheck()[1]) 
						wait(0.5)
						toTarget(QuestCheck()[7][1] * CFrame.new(0,30,20))
					end
				end
			end
		end
	end
end)

-- UI Creation
local LoadingTime = tick()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vuonghuyhung23012007-lang/Automatic-Updates/refs/heads/main/Src"))()
local Window = Library:CreateWindow({Credit = "pindummy"})

-- General Tab
local Page1 = Window:AddPage({
	Title = "General",
	Icon = "home",
	Page = {
		Left = {
			Name = "Farm",
			Icon = "arrow-big-up"
		},
		Right = {
			Name = "Setup",
			Icon = "file-cog"
		}
	}
})

Page1:CreateToggle("Left", {
	Title = "Farm Level",
	Desc = "Level Max 2400",
	Value = _G.Settings.Main["Auto Farm Level"],
	Callback = function(vu)
		_G.Settings.Main["Auto Farm Level"] = vu
		_G.AutoFarmLevelReal = vu
		if vu == false then
			toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
		SaveSettings()
	end
})

Page1:CreateToggle("Left", {
	Title = "Fast Auto Farm Level",
	Desc = "Faster Farm Speed",
	Value = _G.Settings.Main["Fast Auto Farm Level"],
	Callback = function(vu)
		_G.Settings.Main["Fast Auto Farm Level"] = vu
		SaveSettings()
	end
})

Page1:CreateToggle("Left", {
	Title = "Mob Aura",
	Desc = "Attack All Mobs in Range",
	Value = _G.Settings.Main["Mob Aura"],
	Callback = function(vu)
		_G.Settings.Main["Mob Aura"] = vu
		SaveSettings()
	end
})

Page1:CreateSlider("Left", {
	Title = 'Mob Aura Distance',
	Desc = "Max: 5000",
	Min = 100,
	Max = 5000,
	Value = _G.Settings.Main["Distance Mob Aura"],
	Callback = function(vu)
		_G.Settings.Main["Distance Mob Aura"] = vu
		SaveSettings()
	end
})

Page1:CreateDropdown("Right", {
	Title = "Weapon",
	Desc = "Select Weapon Farm",
	ListDesc = "Select Weapon To Farm",
	Value = "Melee",
	List = {"Melee", "Sword", "Fruit"},
	MultiDropdown = false,
	Callback = function(vu)
		SelectWeapon = vu
		SaveSettings()
	end
})

Page1:CreateSlider("Right", {
	Title = 'Distance',
	Desc = "Setup Distance",
	Min = 1,
	Max = 50,
	Value = _G.Settings.Configs["Distance Auto Farm"],
	Callback = function(vu)
		_G.Settings.Configs["Distance Auto Farm"] = vu
		SaveSettings()
	end
})

Page1:CreateLabel("Right", {
	Title = " - Setting Skill",
	Desc = "Select Skill To Use Farm"
})

Page1:CreateToggle("Right", {
	Title = "Skill Z",
	Value = _G.Settings.Configs["Skill Z"],
	Callback = function(vu)
		_G.Settings.Configs["Skill Z"] = vu
		SaveSettings()
	end
})

Page1:CreateToggle("Right", {
	Title = "Skill X",
	Value = _G.Settings.Configs["Skill X"],
	Callback = function(vu)
		_G.Settings.Configs["Skill X"] = vu
		SaveSettings()
	end
})

Page1:CreateToggle("Right", {
	Title = "Skill C",
	Value = _G.Settings.Configs["Skill C"],
	Callback = function(vu)
		_G.Settings.Configs["Skill C"] = vu
		SaveSettings()
	end
})

Page1:CreateToggle("Right", {
	Title = "Skill V",
	Value = _G.Settings.Configs["Skill V"],
	Callback = function(vu)
		_G.Settings.Configs["Skill V"] = vu
		SaveSettings()
	end
})

Page1:CreateButton("Right", {
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

-- Shop Tab
local Page2 = Window:AddPage({
	Title = "Shop",
	Icon = "shopping-cart",
	Page = {
		Left = {
			Name = "Items",
			Icon = "package"
		},
		Right = {
			Name = "Fruits",
			Icon = "apple"
		}
	}
})

Page2:CreateToggle("Left", {
	Title = "Auto Buy Ability",
	Value = _G.Settings.Main["Auto Buy Ablility"],
	Callback = function(vu)
		_G.Settings.Main["Auto Buy Ablility"] = vu
		SaveSettings()
	end
})

Page2:CreateToggle("Left", {
	Title = "Auto Buy Legendary Sword",
	Value = _G.Settings.Main["Auto Buy Legendary Sword"],
	Callback = function(vu)
		_G.Settings.Main["Auto Buy Legendary Sword"] = vu
		SaveSettings()
	end
})

Page2:CreateToggle("Left", {
	Title = "Auto Buy Enchancement Haki",
	Value = _G.Settings.Main["Auto Buy Enchanment Haki"],
	Callback = function(vu)
		_G.Settings.Main["Auto Buy Enchanment Haki"] = vu
		SaveSettings()
	end
})

Page2:CreateToggle("Right", {
	Title = "Auto Buy Random Fruits",
	Value = _G.Settings.Fruits["Auto Buy Random Fruits"],
	Callback = function(vu)
		_G.Settings.Fruits["Auto Buy Random Fruits"] = vu
		SaveSettings()
	end
})

Page2:CreateToggle("Right", {
	Title = "Auto Store Fruits",
	Value = _G.Settings.Fruits["Auto Store Fruits"],
	Callback = function(vu)
		_G.Settings.Fruits["Auto Store Fruits"] = vu
		SaveSettings()
	end
})

Page2:CreateToggle("Right", {
	Title = "Auto Buy Devil Fruits Sniper",
	Value = _G.Settings.Fruits["Auto Buy Devil Fruits Sniper"],
	Callback = function(vu)
		_G.Settings.Fruits["Auto Buy Devil Fruits Sniper"] = vu
		SaveSettings()
	end
})

-- Combat Tab
local Page3 = Window:AddPage({
	Title = "Combat",
	Icon = "swords",
	Page = {
		Left = {
			Name = "Settings",
			Icon = "settings"
		},
		Right = {
			Name = "Mastery",
			Icon = "zap"
		}
	}
})

Page3:CreateToggle("Left", {
	Title = "Fast Attack",
	Value = _G.Settings.Configs["Fast Attack"],
	Callback = function(vu)
		_G.Settings.Configs["Fast Attack"] = vu
		SaveSettings()
	end
})

Page3:CreateDropdown("Left", {
	Title = "Fast Attack Type",
	List = {"Fast", "Normal", "Slow"},
	Value = _G.Settings.Configs["Fast Attack Type"][1],
	Callback = function(vu)
		_G.Settings.Configs["Fast Attack Type"] = {vu}
		SaveSettings()
	end
})

Page3:CreateToggle("Left", {
	Title = "Auto Haki",
	Value = _G.Settings.Configs["Auto Haki"],
	Callback = function(vu)
		_G.Settings.Configs["Auto Haki"] = vu
		SaveSettings()
	end
})

Page3:CreateToggle("Left", {
	Title = "Bring Mob",
	Value = _G.Settings.Configs["Bring Mob"],
	Callback = function(vu)
		_G.Settings.Configs["Bring Mob"] = vu
		SaveSettings()
	end
})

Page3:CreateToggle("Right", {
	Title = "Farm Fruit Mastery",
	Value = _G.Settings.Mastery["Auto Farm Fruit Mastery"],
	Callback = function(vu)
		_G.Settings.Mastery["Auto Farm Fruit Mastery"] = vu
		SaveSettings()
	end
})

Page3:CreateToggle("Right", {
	Title = "Farm Gun Mastery",
	Value = _G.Settings.Mastery["Auto Farm Gun Mastery"],
	Callback = function(vu)
		_G.Settings.Mastery["Auto Farm Gun Mastery"] = vu
		SaveSettings()
	end
})

Page3:CreateSlider("Right", {
	Title = 'Mob Health %',
	Min = 1,
	Max = 100,
	Value = _G.Settings.Mastery["Mob Health (%)"],
	Callback = function(vu)
		_G.Settings.Mastery["Mob Health (%)"] = vu
		SaveSettings()
	end
})

-- Misc Tab
local Page4 = Window:AddPage({
	Title = "Misc",
	Icon = "menu",
	Page = {
		Left = {
			Name = "Movement",
			Icon = "move"
		},
		Right = {
			Name = "Visual",
			Icon = "eye"
		}
	}
})

Page4:CreateToggle("Left", {
	Title = "No Soru Cooldown",
	Value = _G.Settings.Misc["No Soru Cooldown"],
	Callback = function(vu)
		_G.Settings.Misc["No Soru Cooldown"] = vu
		SaveSettings()
	end
})

Page4:CreateToggle("Left", {
	Title = "No Dash Cooldown",
	Value = _G.Settings.Misc["No Dash Cooldown"],
	Callback = function(vu)
		_G.Settings.Misc["No Dash Cooldown"] = vu
		SaveSettings()
	end
})

Page4:CreateToggle("Left", {
	Title = "Infinite Geppo",
	Value = _G.Settings.Misc["Infinities Geppo"],
	Callback = function(vu)
		_G.Settings.Misc["Infinities Geppo"] = vu
		SaveSettings()
	end
})

Page4:CreateToggle("Left", {
	Title = "Infinite Energy",
	Value = _G.Settings.Misc["Infinities Energy"],
	Callback = function(vu)
		_G.Settings.Misc["Infinities Energy"] = vu
		SaveSettings()
	end
})

Page4:CreateToggle("Right", {
	Title = "No Fog",
	Value = _G.Settings.Misc["No Fog"],
	Callback = function(vu)
		_G.Settings.Misc["No Fog"] = vu
		SaveSettings()
	end
})

Page4:CreateToggle("Right", {
	Title = "No Camera Shake",
	Value = _G.Settings.Configs["Camera Shaker"],
	Callback = function(vu)
		_G.Settings.Configs["Camera Shaker"] = vu
		SaveSettings()
	end
})

-- Extra Tab
local Page5 = Window:AddPage({
	Title = "Extra",
	Icon = "plus-circle",
	Page = {
		Left = {
			Name = "Stats",
			Icon = "bar-chart"
		},
		Right = {
			Name = "Server",
			Icon = "server"
		}
	}
})

Page5:CreateToggle("Left", {
	Title = "Enable Auto Stats",
	Value = _G.Settings.Stat["Enabled Auto Stats"],
	Callback = function(vu)
		_G.Settings.Stat["Enabled Auto Stats"] = vu
		SaveSettings()
	end
})

Page5:CreateToggle("Left", {
	Title = "Auto Stats Kaitun",
	Value = _G.Settings.Stat["Auto Stats Kaitun"],
	Callback = function(vu)
		_G.Settings.Stat["Auto Stats Kaitun"] = vu
		SaveSettings()
	end
})

Page5:CreateDropdown("Left", {
	Title = "Select Stats",
	List = {"Melee", "Defense", "Sword", "Devil Fruit", "Gun"},
	Value = _G.Settings.Stat["Select Stats"][1],
	Callback = function(vu)
		_G.Settings.Stat["Select Stats"] = {vu}
		SaveSettings()
	end
})

Page5:CreateSlider("Left", {
	Title = 'Point Select',
	Min = 1,
	Max = 9,
	Value = _G.Settings.Stat["Point Select"],
	Callback = function(vu)
		_G.Settings.Stat["Point Select"] = vu
		SaveSettings()
	end
})

Page5:CreateToggle("Right", {
	Title = "Auto Rejoin",
	Value = _G.Settings.Misc["Auto Rejoin"],
	Callback = function(vu)
		_G.Settings.Misc["Auto Rejoin"] = vu
		SaveSettings()
	end
})

-- Fast Attack Loop
coroutine.wrap(function()
	while task.wait(.1) do
		local ac = CombatFrameworkR.activeController
		if ac and ac.equipped then
			if FastAttack and _G.Settings.Configs["Fast Attack"] then
				AttackFunction()
				if _G.Settings.Configs["Fast Attack Type"][1] == "Normal" then
					if tick() - cooldownfastattack > .9 then wait(.1) cooldownfastattack = tick() end
				elseif _G.Settings.Configs["Fast Attack Type"][1] == "Fast" then
					if tick() - cooldownfastattack > 1.5 then wait(.01) cooldownfastattack = tick() end
				elseif _G.Settings.Configs["Fast Attack Type"][1] == "Slow" then
					if tick() - cooldownfastattack > .3 then wait(.7) cooldownfastattack = tick() end
				end
			elseif FastAttack and _G.Settings.Configs["Fast Attack"] == false then
				if ac.hitboxMagnitude ~= 55 then
					ac.hitboxMagnitude = 55
				end
				ac:attack()
			end
		end
	end
end)()

-- Auto Haki Loop
spawn(function()
	while wait() do
		if _G.Settings.Configs["Auto Haki"] then
			if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
			end
		end
	end
end)

-- Weapon Selection
task.spawn(function()
	while wait() do
		pcall(function()
			if SelectWeapon == "Melee" then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			elseif SelectWeapon == "Sword" then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			elseif SelectWeapon == "Fruit" then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			end
		end)
	end
end)

-- Anti-Fall/Fly
spawn(function()
	while wait() do 
		if _G.AutoFarmLevelReal then
			if syn then
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
				end
			else
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
						if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
							game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
						end
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.Name = "BodyVelocity1"
						BodyVelocity.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
						BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
						BodyVelocity.Velocity = Vector3.new(0, 0, 0)
					end
				end
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false    
					end
				end
			end
		else
			if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
				game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
			end
		end
	end
end)

print("Script Loaded Successfully!")
print("Loading Time: " .. tostring(tick() - LoadingTime) .. " seconds")
