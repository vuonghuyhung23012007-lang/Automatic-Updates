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
title.Size = UDim2.new(0, 200, 0, 70)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BLOX FRUITS"
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
tabsLayout.Padding = UDim.new(0, 12)
tabsLayout.Parent = tabsContainer

-- Current active tab
local currentTab = "Auto Farm"

-- Content frames for each tab
local contentFrames = {}

-- Function to create tab button with icon
local function createTabButton(name, iconId)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "Tab"
    tabBtn.Size = UDim2.new(0, 120, 0, 45)
    tabBtn.BackgroundColor3 = (name == currentTab) and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(28, 28, 35)
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    tabBtn.Text = ""
    tabBtn.Parent = tabsContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tabBtn
    
    -- Icon
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 12, 0.5, -12)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = (name == currentTab) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    icon.Parent = tabBtn
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 42, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name:upper()
    label.TextColor3 = (name == currentTab) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = tabBtn
    
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
                local childIcon = child:FindFirstChild("Icon")
                local childLabel = child:FindFirstChild("Label")
                if childIcon then childIcon.ImageColor3 = Color3.fromRGB(180, 180, 180) end
                if childLabel then childLabel.TextColor3 = Color3.fromRGB(180, 180, 180) end
            end
        end
        
        -- Update current tab
        currentTab = name
        tabBtn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Show/hide content frames
        for tabName, frame in pairs(contentFrames) do
            frame.Visible = (tabName == name)
        end
        
        print("Switched to " .. name .. " tab")
    end)
    
    return tabBtn
end

-- Create tabs
createTabButton("Auto Farm", "rbxassetid://7743866903")
createTabButton("Combat", "rbxassetid://7743868000")
createTabButton("Misc", "rbxassetid://7743869154")
createTabButton("Stats", "rbxassetid://7743871002")
createTabButton("Teleport", "rbxassetid://7743872365")

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
contentFrames["Auto Farm"] = createContentFrame("Auto Farm")
contentFrames["Combat"] = createContentFrame("Combat")
contentFrames["Misc"] = createContentFrame("Misc")
contentFrames["Stats"] = createContentFrame("Stats")
contentFrames["Teleport"] = createContentFrame("Teleport")

-- Function to create feature button
local function createFeatureButton(tabName, name, iconId, description)
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
    
    -- Icon
    local featureIcon = Instance.new("ImageLabel")
    featureIcon.Name = "Icon"
    featureIcon.Size = UDim2.new(0, 40, 0, 40)
    featureIcon.Position = UDim2.new(0, 15, 0.5, -20)
    featureIcon.BackgroundTransparency = 1
    featureIcon.Image = iconId
    featureIcon.ImageColor3 = Color3.fromRGB(147, 112, 219)
    featureIcon.Parent = featureFrame
    
    -- Title
    local featureTitle = Instance.new("TextLabel")
    featureTitle.Name = "Title"
    featureTitle.Size = UDim2.new(1, -180, 0, 25)
    featureTitle.Position = UDim2.new(0, 65, 0, 10)
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
    featureDesc.Size = UDim2.new(1, -180, 0, 20)
    featureDesc.Position = UDim2.new(0, 65, 0, 35)
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
createFeatureButton("Auto Farm", "Auto Farm Level", "rbxassetid://7743866903", "Automatically farm enemies for levels")
createFeatureButton("Auto Farm", "Auto Farm Mastery", "rbxassetid://7743866903", "Farm weapon and fruit mastery")
createFeatureButton("Auto Farm", "Auto Farm Boss", "rbxassetid://7743868000", "Automatically defeat bosses")
createFeatureButton("Auto Farm", "Auto Farm Fruit", "rbxassetid://7743869154", "Hunt for devil fruits")
createFeatureButton("Auto Farm", "Auto Quest", "rbxassetid://7743871002", "Complete quests automatically")
createFeatureButton("Auto Farm", "Auto Observation Haki", "rbxassetid://7743872365", "Train Observation Haki")

-- Create features for Combat tab
createFeatureButton("Combat", "Auto Combat", "rbxassetid://7743868000", "Automatically attack enemies")
createFeatureButton("Combat", "Aimbot", "rbxassetid://7743868000", "Auto aim at targets")
createFeatureButton("Combat", "Kill Aura", "rbxassetid://7743868000", "Attack nearby enemies")

-- Create features for Misc tab
createFeatureButton("Misc", "Auto Collect Chests", "rbxassetid://7743869154", "Collect all chests automatically")
createFeatureButton("Misc", "No Clip", "rbxassetid://7743869154", "Walk through walls")
createFeatureButton("Misc", "Fly", "rbxassetid://7743869154", "Enable fly mode")

-- Create features for Stats tab
createFeatureButton("Stats", "Auto Melee", "rbxassetid://7743871002", "Auto upgrade melee stats")
createFeatureButton("Stats", "Auto Defense", "rbxassetid://7743871002", "Auto upgrade defense stats")
createFeatureButton("Stats", "Auto Sword", "rbxassetid://7743871002", "Auto upgrade sword stats")

-- Create features for Teleport tab
createFeatureButton("Teleport", "Teleport to Sea 1", "rbxassetid://7743872365", "Teleport to first sea")
createFeatureButton("Teleport", "Teleport to Sea 2", "rbxassetid://7743872365", "Teleport to second sea")
createFeatureButton("Teleport", "Teleport to Sea 3", "rbxassetid://7743872365", "Teleport to third sea")

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
