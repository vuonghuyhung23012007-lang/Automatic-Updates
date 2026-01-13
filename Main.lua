-- Blox Fruits Menu UI Script
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsMenuUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Toggle Button (Logo để bật/tắt menu)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "🎮"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 30
toggleButton.Visible = false
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
mainFrame.Parent = screenGui

-- UICorner for main frame
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
title.Text = "BLOX FRUITS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.RichText = false
title.Parent = headerBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Text = "✕"
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

-- Function to create tab button (text only)
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
    tabBtn.RichText = false
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
        -- Update previous tab
        for _, child in pairs(tabsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        
        -- Update current tab
        currentTab = name
        tabBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Show/hide content frames
        for tabName, frame in pairs(contentFrames) do
            frame.Visible = (tabName == name)
        end
        
        print("Switched to " .. name .. " tab")
    end)
    
    return tabBtn
end

-- Create tabs
createTabButton("AUTO FARM")
createTabButton("COMBAT")
createTabButton("MISC")
createTabButton("STATS")
createTabButton("TELEPORT")

-- Function to create content frame for each tab
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

-- Create content frames for all tabs
contentFrames["AUTO FARM"] = createContentFrame("AUTO FARM")
contentFrames["COMBAT"] = createContentFrame("COMBAT")
contentFrames["MISC"] = createContentFrame("MISC")
contentFrames["STATS"] = createContentFrame("STATS")
contentFrames["TELEPORT"] = createContentFrame("TELEPORT")

-- Function to create feature button (no icon)
local function createFeatureButton(tabName, name, description)
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
    featureTitle.RichText = false
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
    featureDesc.RichText = false
    featureDesc.Parent = featureFrame
    
    -- Toggle Button
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleButton"
    toggleBtn.Size = UDim2.new(0, 90, 0, 35)
    toggleBtn.Position = UDim2.new(1, -105, 0.5, -17.5)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 12
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = featureFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    local isToggled = false
    toggleBtn.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
            toggleBtn.Text = "ON"
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            print(name .. " enabled!")
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            toggleBtn.Text = "OFF"
            toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            print(name .. " disabled!")
        end
    end)
    
    return featureFrame
end

-- Create features for Auto Farm tab
createFeatureButton("AUTO FARM", "Auto Farm Level", "Automatically farm enemies for levels")
createFeatureButton("AUTO FARM", "Auto Farm Mastery", "Farm weapon and fruit mastery")
createFeatureButton("AUTO FARM", "Auto Farm Boss", "Automatically defeat bosses")
createFeatureButton("AUTO FARM", "Auto Farm Fruit", "Hunt for devil fruits")
createFeatureButton("AUTO FARM", "Auto Quest", "Complete quests automatically")
createFeatureButton("AUTO FARM", "Auto Observation Haki", "Train Observation Haki")

-- Create features for Combat tab
createFeatureButton("COMBAT", "Auto Combat", "Automatically attack enemies")
createFeatureButton("COMBAT", "Aimbot", "Auto aim at targets")
createFeatureButton("COMBAT", "Kill Aura", "Attack nearby enemies")
createFeatureButton("COMBAT", "Auto Skill", "Automatically use skills")

-- Create features for Misc tab
createFeatureButton("MISC", "Auto Collect Chests", "Collect all chests automatically")
createFeatureButton("MISC", "No Clip", "Walk through walls")
createFeatureButton("MISC", "Fly", "Enable fly mode")
createFeatureButton("MISC", "Speed Hack", "Increase movement speed")

-- Create features for Stats tab
createFeatureButton("STATS", "Auto Melee", "Auto upgrade melee stats")
createFeatureButton("STATS", "Auto Defense", "Auto upgrade defense stats")
createFeatureButton("STATS", "Auto Sword", "Auto upgrade sword stats")
createFeatureButton("STATS", "Auto Gun", "Auto upgrade gun stats")

-- Create features for Teleport tab
createFeatureButton("TELEPORT", "Teleport to Sea 1", "Teleport to first sea")
createFeatureButton("TELEPORT", "Teleport to Sea 2", "Teleport to second sea")
createFeatureButton("TELEPORT", "Teleport to Sea 3", "Teleport to third sea")
createFeatureButton("TELEPORT", "Teleport to Shop", "Teleport to shop")

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    toggleButton.Visible = false
end)

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    toggleButton.Visible = true
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

print("✅ Blox Fruits Menu UI loaded successfully!")
