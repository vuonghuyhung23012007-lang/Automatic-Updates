-- Blox Fruits Menu UI Script với tất cả function từ script gốc
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==============================================
-- TẤT CẢ FUNCTION TỪ SCRIPT GỐC
-- ==============================================

-- Biến global và settings
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

-- Variables
local CombatFramework, CombatFrameworkR, RigController, RigControllerR, realbhit
local cooldownfastattack = tick()
_G.AutoFarmLevelReal = false
local FastAttack = false
local BringMobFarm = false
local PosMon
local SetCFarme = 1
local SelectWeapon = "Melee"

-- Required modules
pcall(function()
    CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
    CombatFrameworkR = getupvalues(CombatFramework)[2]
    RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
    RigControllerR = getupvalues(RigController)[2]
    realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
end)

-- ==================== CORE FUNCTIONS ====================

function getAllBladeHits(Sizes)
    local Hits = {}
    local Client = game.Players.LocalPlayer
    local Enemies = game:GetService("Workspace").Enemies:GetChildren()
    for i=1,#Enemies do local v = Enemies[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
            table.insert(Hits,Human.RootPart)
        end
    end
    return Hits
end

function CurrentWeapon()
    if not CombatFrameworkR then return "" end
    local ac = CombatFrameworkR.activeController
    if not ac then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name or "" end
    
    local ret = ac.blades and ac.blades[1]
    if not ret then 
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        return tool and tool.Name or ""
    end
    
    pcall(function()
        while ret and ret.Parent ~= game.Players.LocalPlayer.Character do 
            ret = ret.Parent 
        end
    end)
    
    if not ret then 
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        return tool and tool.Name or ""
    end
    
    return ret.Name
end

function AttackFunction()
    if not CombatFrameworkR then return end
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
                
                local weaponName = CurrentWeapon()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", weaponName)
                    game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
                end
            end
        end
    end
end

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
            local success, Decode = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"))
            end)
            if success and Decode then
                for i,v in pairs(Decode) do
                    if _G.Settings[i] ~= nil then
                        if type(v) == "table" then
                            for i2,v2 in pairs(v) do
                                _G.Settings[i][i2] = v2
                            end
                        else
                            _G.Settings[i] = v
                        end
                    end
                end
            end
        end
    end
end

function SaveSettings()
    if readfile and writefile and isfile and isfolder then
        if not isfile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json") then
            LoadSettings()
        else
            local Array = {}
            for i,v in pairs(_G.Settings) do
                Array[i] = v
            end
            writefile("Silver Hub Premium Scripts/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", game:GetService("HttpService"):JSONEncode(Array))
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

function UnEquipWeapon(Weapon)
    if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
        _G.NotAutoEquip = true
        wait(.5)
        game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
        wait(.1)
        _G.NotAutoEquip = false
    end
end

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

function GetIsLand(...)
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

    if not RealTarget or not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        return {Stop = function() end, Wait = function() end}
    end

    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then 
        return {Stop = function() end, Wait = function() end}
    end

    local tweenfunc = {}
    local Distance = (RealTarget.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed = 300
    if Distance < 1000 then
        Speed = 315
    end

    local tween_s = game:service"TweenService"
    local info = TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear)
    local tweenw, tween = pcall(function()
        return tween_s:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = RealTarget})
    end)
    
    if tweenw and tween then
        tween:Play()
        
        function tweenfunc:Stop()
            if tween then
                tween:Cancel()
            end
        end 
        
        function tweenfunc:Wait()
            if tween then
                tween.Completed:Wait()
            end
        end 
    else
        function tweenfunc:Stop() end
        function tweenfunc:Wait() wait(1) end
    end

    return tweenfunc
end

-- ==================== AUTO ATTACK SYSTEM ====================

spawn(function()
    while task.wait(.1) do
        if CombatFrameworkR then
            local ac = CombatFrameworkR.activeController
            if ac and ac.equipped then
                if FastAttack and _G.Settings.Configs["Fast Attack"] then
                    AttackFunction()
                    if _G.Settings.Configs["Fast Attack Type"] and _G.Settings.Configs["Fast Attack Type"][1] then
                        local attackType = _G.Settings.Configs["Fast Attack Type"][1]
                        if attackType == "Normal" then
                            if tick() - cooldownfastattack > .9 then wait(.1) cooldownfastattack = tick() end
                        elseif attackType == "Fast" then
                            if tick() - cooldownfastattack > 1.5 then wait(.01) cooldownfastattack = tick() end
                        elseif attackType == "Slow" then
                            if tick() - cooldownfastattack > .3 then wait(.7) cooldownfastattack = tick() end
                        end
                    end
                elseif FastAttack and not _G.Settings.Configs["Fast Attack"] then
                    if ac.hitboxMagnitude ~= 55 then
                        ac.hitboxMagnitude = 55
                    end
                    ac:attack()
                end
            end
        end
    end
end)

-- ==================== AUTO HAKI ====================

spawn(function()
    while wait() do
        if _G.Settings.Configs["Auto Haki"] then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- ==================== WEAPON SELECTION ====================

task.spawn(function()
    while wait() do
        pcall(function()
            if SelectWeapon == "Melee" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            _G.Settings.Configs["Select Weapon"] = {v.Name}
                        end
                    end
                end
            elseif SelectWeapon == "Sword" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Sword" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            _G.Settings.Configs["Select Weapon"] = {v.Name}
                        end
                    end
                end
            elseif SelectWeapon == "Fruit" then
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Blox Fruit" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            _G.Settings.Configs["Select Weapon"] = {v.Name}
                        end
                    end
                end
            else
                for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                            _G.Settings.Configs["Select Weapon"] = {v.Name}
                        end
                    end
                end
            end
        end)
    end
end)

-- ==================== NO CLIP SYSTEM ====================

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
                    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
                        end
                        local BodyVelocity = Instance.new("BodyVelocity")
                        BodyVelocity.Name = "BodyVelocity1"
                        BodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
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

-- ==================== SIMULATION RADIUS ====================

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

-- ==============================================
-- UI SYSTEM - SỬA ĐỂ HIỆN MENU NGAY LẬP TỨC
-- ==============================================

-- Create ScreenGui (ĐẶT Ở ĐÂY SAU CÁC FUNCTION)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsMenuUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999  -- Hiển thị trên cùng
screenGui.Parent = playerGui

-- Toggle Button (HIỆN NGAY KHI SCRIPT CHẠY)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "🤗"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 30
toggleButton.Visible = true  -- QUAN TRỌNG: HIỂN THỊ NGAY
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 12)
toggleCorner.Parent = toggleButton

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 380)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false  -- Menu chính ẩn ban đầu
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Top Header Bar
local headerBar = Instance.new("Frame")
headerBar.Name = "HeaderBar"
headerBar.Size = UDim2.new(1, 0, 0, 70)
headerBar.Position = UDim2.new(0, 0, 0, 0)
headerBar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
headerBar.BorderSizePixel = 0
headerBar.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = headerBar

-- Header Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 300, 0, 70)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Megapixel"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = headerBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 0
closeBtn.Parent = headerBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Navigation Tabs Container
local tabsContainer = Instance.new("Frame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Size = UDim2.new(1, -40, 0, 50)
tabsContainer.Position = UDim2.new(0, 20, 0, 85)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = mainFrame

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.FillDirection = Enum.FillDirection.Horizontal
tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.Parent = tabsContainer

-- Current active tab
local currentTab = "AUTO FARM"

-- Content frames for each tab
local contentFrames = {}

-- Function to create tab button
local function createTabButton(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "Tab"
    tabBtn.Size = UDim2.new(0, 115, 0, 45)
    tabBtn.BackgroundColor3 = (name == currentTab) and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(28, 28, 35)
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    tabBtn.Text = name
    tabBtn.TextColor3 = (name == currentTab) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 12
    tabBtn.Parent = tabsContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tabBtn
    
    -- Hover effect
    tabBtn.MouseEnter:Connect(function()
        if name ~= currentTab then
            tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        end
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if name ~= currentTab then
            tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        end
    end)
    
    -- Click to switch tabs
    tabBtn.MouseButton1Click:Connect(function()
        for _, child in pairs(tabsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        
        currentTab = name
        tabBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        for tabName, frame in pairs(contentFrames) do
            frame.Visible = (tabName == name)
        end
    end)
    
    return tabBtn
end

-- Create tabs
createTabButton("AUTO FARM")
createTabButton("COMBAT")
createTabButton("MISC")
createTabButton("STATS")
createTabButton("TELEPORT")

-- Function to create content frame
local function createContentFrame(tabName)
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = tabName .. "Content"
    contentFrame.Size = UDim2.new(1, -40, 1, -160)
    contentFrame.Position = UDim2.new(0, 20, 0, 150)
    contentFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentFrame.Visible = (tabName == currentTab)
    contentFrame.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 10)
    contentCorner.Parent = contentFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = contentFrame
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 15)
    contentPadding.PaddingBottom = UDim.new(0, 15)
    contentPadding.PaddingLeft = UDim.new(0, 15)
    contentPadding.PaddingRight = UDim.new(0, 15)
    contentPadding.Parent = contentFrame
    
    return contentFrame
end

-- Create content frames
contentFrames["AUTO FARM"] = createContentFrame("AUTO FARM")
contentFrames["COMBAT"] = createContentFrame("COMBAT")
contentFrames["MISC"] = createContentFrame("MISC")
contentFrames["STATS"] = createContentFrame("STATS")
contentFrames["TELEPORT"] = createContentFrame("TELEPORT")

-- Function to get setting value
local function getSetting(path)
    local parts = string.split(path, ".")
    local current = _G.Settings
    for _, part in ipairs(parts) do
        if current[part] ~= nil then
            current = current[part]
        else
            return nil
        end
    end
    return current
end

-- Function to set setting value
local function setSetting(path, value)
    local parts = string.split(path, ".")
    local current = _G.Settings
    for i = 1, #parts - 1 do
        if current[parts[i]] == nil then
            current[parts[i]] = {}
        end
        current = current[parts[i]]
    end
    current[parts[#parts]] = value
    SaveSettings()
end

-- Function to create toggle button
local function createToggleButton(tabName, name, description, settingPath, defaultValue)
    local contentFrame = contentFrames[tabName]
    if not contentFrame then return end
    
    local featureFrame = Instance.new("Frame")
    featureFrame.Name = name .. "Feature"
    featureFrame.Size = UDim2.new(1, -30, 0, 70)
    featureFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    featureFrame.BorderSizePixel = 0
    featureFrame.Parent = contentFrame
    
    local featureCorner = Instance.new("UICorner")
    featureCorner.CornerRadius = UDim.new(0, 10)
    featureCorner.Parent = featureFrame
    
    -- Title
    local featureTitle = Instance.new("TextLabel")
    featureTitle.Name = "Title"
    featureTitle.Size = UDim2.new(1, -130, 0, 25)
    featureTitle.Position = UDim2.new(0, 20, 0, 10)
    featureTitle.BackgroundTransparency = 1
    featureTitle.Text = name
    featureTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    featureTitle.Font = Enum.Font.GothamBold
    featureTitle.TextSize = 14
    featureTitle.TextXAlignment = Enum.TextXAlignment.Left
    featureTitle.Parent = featureFrame
    
    -- Description
    local featureDesc = Instance.new("TextLabel")
    featureDesc.Name = "Description"
    featureDesc.Size = UDim2.new(1, -130, 0, 20)
    featureDesc.Position = UDim2.new(0, 20, 0, 35)
    featureDesc.BackgroundTransparency = 1
    featureDesc.Text = description
    featureDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    featureDesc.Font = Enum.Font.Gotham
    featureDesc.TextSize = 11
    featureDesc.TextXAlignment = Enum.TextXAlignment.Left
    featureDesc.Parent = featureFrame
    
    -- Toggle Button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleButton"
    toggleBtn.Size = UDim2.new(0, 90, 0, 35)
    toggleBtn.Position = UDim2.new(1, -105, 0.5, -17.5)
    
    -- Get current value
    local currentValue = defaultValue
    if settingPath then
        local value = getSetting(settingPath)
        if value ~= nil then
            if type(value) == "table" and #value > 0 then
                currentValue = value[1] == true or value == true
            else
                currentValue = value == true
            end
        end
    end
    
    -- Set button appearance
    if currentValue then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        toggleBtn.Text = "ON"
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        toggleBtn.Text = "OFF"
        toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 12
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = featureFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    -- Toggle click
    toggleBtn.MouseButton1Click:Connect(function()
        local isToggled = (toggleBtn.Text == "ON")
        isToggled = not isToggled
        
        if isToggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
            toggleBtn.Text = "ON"
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            toggleBtn.Text = "OFF"
            toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        -- Update setting
        if settingPath then
            setSetting(settingPath, isToggled)
            
            -- Special handling for specific features
            if settingPath == "Main.Auto Farm Level" then
                _G.AutoFarmLevelReal = isToggled
                FastAttack = isToggled
                if not isToggled then
                    -- Stop any active farming
                    BringMobFarm = false
                end
            elseif settingPath == "Configs.Fast Attack" then
                FastAttack = isToggled
            elseif settingPath == "Configs.Auto Haki" then
                -- Already handled by auto haki system
            elseif settingPath == "Misc.Fly" then
                -- Fly system could be implemented here
            end
        end
        
        print(name .. (isToggled and " enabled!" or " disabled!"))
    end)
    
    return featureFrame
end

-- Function to create dropdown button
local function createDropdownButton(tabName, name, description, settingPath, options, defaultValue)
    local contentFrame = contentFrames[tabName]
    if not contentFrame then return end
    
    local featureFrame = Instance.new("Frame")
    featureFrame.Name = name .. "Feature"
    featureFrame.Size = UDim2.new(1, -30, 0, 70)
    featureFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    featureFrame.BorderSizePixel = 0
    featureFrame.Parent = contentFrame
    
    local featureCorner = Instance.new("UICorner")
    featureCorner.CornerRadius = UDim.new(0, 10)
    featureCorner.Parent = featureFrame
    
    -- Title
    local featureTitle = Instance.new("TextLabel")
    featureTitle.Name = "Title"
    featureTitle.Size = UDim2.new(1, -130, 0, 25)
    featureTitle.Position = UDim2.new(0, 20, 0, 10)
    featureTitle.BackgroundTransparency = 1
    featureTitle.Text = name
    featureTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    featureTitle.Font = Enum.Font.GothamBold
    featureTitle.TextSize = 14
    featureTitle.TextXAlignment = Enum.TextXAlignment.Left
    featureTitle.Parent = featureFrame
    
    -- Description
    local featureDesc = Instance.new("TextLabel")
    featureDesc.Name = "Description"
    featureDesc.Size = UDim2.new(1, -130, 0, 20)
    featureDesc.Position = UDim2.new(0, 20, 0, 35)
    featureDesc.BackgroundTransparency = 1
    featureDesc.Text = description
    featureDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    featureDesc.Font = Enum.Font.Gotham
    featureDesc.TextSize = 11
    featureDesc.TextXAlignment = Enum.TextXAlignment.Left
    featureDesc.Parent = featureFrame
    
    -- Dropdown Button
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Name = "DropdownButton"
    dropdownBtn.Size = UDim2.new(0, 90, 0, 35)
    dropdownBtn.Position = UDim2.new(1, -105, 0.5, -17.5)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    dropdownBtn.Text = "SELECT"
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    dropdownBtn.Font = Enum.Font.GothamBold
    dropdownBtn.TextSize = 12
    dropdownBtn.BorderSizePixel = 0
    dropdownBtn.Parent = featureFrame
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 8)
    dropdownCorner.Parent = dropdownBtn
    
    -- Get current value
    local currentValue = defaultValue or options[1]
    if settingPath then
        local value = getSetting(settingPath)
        if value ~= nil then
            if type(value) == "table" and #value > 0 then
                currentValue = value[1]
            else
                currentValue = value
            end
        end
    end
    
    dropdownBtn.Text = tostring(currentValue)
    
    -- Dropdown click
    local currentIndex = 1
    for i, option in ipairs(options) do
        if tostring(option) == tostring(currentValue) then
            currentIndex = i
            break
        end
    end
    
    dropdownBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then
            currentIndex = 1
        end
        
        local selected = options[currentIndex]
        dropdownBtn.Text = tostring(selected)
        
        -- Update setting
        if settingPath then
            setSetting(settingPath, {tostring(selected)})
            
            -- Special handling
            if settingPath == "Configs.Fast Attack Type" then
                -- Already handled by attack system
            elseif settingPath == "Configs.Select Weapon" then
                SelectWeapon = tostring(selected)
            end
        end
        
        print(name .. " set to: " .. tostring(selected))
    end)
    
    return featureFrame
end

-- ==================== CREATE UI ELEMENTS ====================

-- Auto Farm tab
createToggleButton("AUTO FARM", "Auto Farm Level", "Automatically farm enemies for levels", "Main.Auto Farm Level", false)
createToggleButton("AUTO FARM", "Mob Aura", "Auto attack nearby enemies", "Main.Mob Aura", false)
createToggleButton("AUTO FARM", "Fast Auto Farm", "Fast auto farm mode", "Main.Fast Auto Farm Level", false)
createToggleButton("AUTO FARM", "Auto New World", "Auto advance to New World", "Main.Auto New World", false)
createToggleButton("AUTO FARM", "Auto Saber", "Auto farm Saber", "Main.Auto Saber", false)
createToggleButton("AUTO FARM", "Auto Pole", "Auto farm Pole", "Main.Auto Pole", false)

-- Combat tab
createToggleButton("COMBAT", "Fast Attack", "Enable fast attacks", "Configs.Fast Attack", true)
createToggleButton("COMBAT", "Auto Haki", "Auto activate Buso Haki", "Configs.Auto Haki", true)
createToggleButton("COMBAT", "Skill Z", "Auto use Skill Z", "Configs.Skill Z", true)
createToggleButton("COMBAT", "Skill X", "Auto use Skill X", "Configs.Skill X", true)
createToggleButton("COMBAT", "Skill C", "Auto use Skill C", "Configs.Skill C", true)
createToggleButton("COMBAT", "Skill V", "Auto use Skill V", "Configs.Skill V", true)
createDropdownButton("COMBAT", "Fast Attack Type", "Select attack speed", "Configs.Fast Attack Type", {"Fast", "Normal", "Slow"}, "Fast")

-- Misc tab
createToggleButton("MISC", "No Clip", "Walk through walls", "Misc.No Clip", false)
createToggleButton("MISC", "Fly", "Enable fly mode", "Misc.Fly", false)
createToggleButton("MISC", "Auto Rejoin", "Auto rejoin when kicked", "Misc.Auto Rejoin", true)
createToggleButton("MISC", "No Fog", "Remove fog effect", "Misc.No Fog", false)
createToggleButton("MISC", "Wall-TP", "Teleport through walls", "Misc.Wall-TP", false)
createToggleButton("MISC", "No Soru Cooldown", "Remove Soru cooldown", "Misc.No Soru Cooldown", false)
createToggleButton("MISC", "No Dash Cooldown", "Remove Dash cooldown", "Misc.No Dash Cooldown", false)

-- Stats tab
createToggleButton("STATS", "Auto Stats", "Auto upgrade stats", "Stat.Enabled Auto Stats", false)
createToggleButton("STATS", "Auto Redeem Code", "Auto redeem codes", "Stat.Enabled Auto Redeem Code", false)
createDropdownButton("STATS", "Select Stats", "Select stat to upgrade", "Stat.Select Stats", {"Melee", "Defense", "Sword", "Devil Fruit", "Gun", "Max Stats"}, "Melee")

-- Teleport tab
createToggleButton("TELEPORT", "Teleport Sea Beast", "Teleport to Sea Beast", "Teleport.Teleport to Sea Beast", false)
createDropdownButton("TELEPORT", "Select Team", "Select your team", "Configs.Select Team", {"Pirate", "Marine"}, "Pirate")

-- Weapon Selection
createDropdownButton("COMBAT", "Select Weapon", "Select weapon type", nil, {"Melee", "Sword", "Fruit"}, "Melee")

-- ==================== UI CONTROLS ====================

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    toggleButton.Visible = false
    print("Menu opened")
end)

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    toggleButton.Visible = true
    print("Menu closed")
end)

-- Make draggable
local dragging = false
local dragInput, mousePos, framePos

headerBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

headerBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        mainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- ==================== KHỞI ĐỘNG SCRIPT ====================

-- Load settings khi script bắt đầu
LoadSettings()

-- Áp dụng settings ban đầu
if _G.Settings.Configs["Fast Attack"] then
    FastAttack = true
end

if _G.Settings.Main["Auto Farm Level"] then
    _G.AutoFarmLevelReal = true
    FastAttack = true
end

-- Hiển thị thông báo thành công
print("==========================================")
print("Blox Fruits Menu UI đã được tải thành công!")
print("==========================================")
print("Nhấn vào nút tím góc trái để mở menu")
print("Tắt menu bằng nút X đỏ góc phải")
print("==========================================")

-- Đảm bảo UI hiển thị
wait(1)
if toggleButton and toggleButton.Parent then
    print("✓ Toggle button đã sẵn sàng")
else
    warn("✗ Toggle button không tồn tại!")
end

if mainFrame and mainFrame.Parent then
    print("✓ Main frame đã sẵn sàng")
else
    warn("✗ Main frame không tồn tại!")
end
