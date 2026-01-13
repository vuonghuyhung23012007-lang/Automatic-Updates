-- Blox Fruits Menu UI Script
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsMenuUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- UICorner for main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0
shadow.Parent = mainFrame

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

-- Status Badge
local statusBadge = Instance.new("Frame")
statusBadge.Name = "StatusBadge"
statusBadge.Size = UDim2.new(0, 110, 0, 32)
statusBadge.Position = UDim2.new(1, -130, 0.5, -16)
statusBadge.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
statusBadge.BorderSizePixel = 0
statusBadge.Parent = headerBar

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusBadge

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "PREMIUM"
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 13
statusText.Parent = statusBadge

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

-- Function to create tab button with icon
local function createTabButton(name, iconId, active)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name .. "Tab"
    tabBtn.Size = UDim2.new(0, 120, 0, 45)
    tabBtn.BackgroundColor3 = active and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(28, 28, 35)
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
    icon.ImageColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    icon.Parent = tabBtn
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 42, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name:upper()
    label.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = tabBtn
    
    -- Hover effect
    tabBtn.MouseEnter:Connect(function()
        if not active then
            tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
        end
    end)
    
    tabBtn.MouseLeave:Connect(function()
        if not active then
            tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        end
    end)
    
    return tabBtn
end

-- Create tabs
local autoFarmTab = createTabButton("Auto Farm", "rbxassetid://7743866903", true)
local combatTab = createTabButton("Combat", "rbxassetid://7743868000", false)
local statsTab = createTabButton("Stats", "rbxassetid://7743869154", false)
local teleportTab = createTabButton("Teleport", "rbxassetid://7743871002", false)
local miscTab = createTabButton("Misc", "rbxassetid://7743872365", false)

-- Content Area
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -40, 1, -260)
contentFrame.Position = UDim2.new(0, 20, 0, 150)
contentFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
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

-- Function to create feature button
local function createFeatureButton(name, iconId, description)
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

-- Create features
createFeatureButton("Auto Farm Level", "rbxassetid://7743866903", "Automatically farm enemies for levels")
createFeatureButton("Auto Farm Mastery", "rbxassetid://7743866903", "Farm weapon and fruit mastery")
createFeatureButton("Auto Farm Boss", "rbxassetid://7743868000", "Automatically defeat bosses")
createFeatureButton("Auto Farm Fruit", "rbxassetid://7743869154", "Hunt for devil fruits")
createFeatureButton("Auto Quest", "rbxassetid://7743871002", "Complete quests automatically")
createFeatureButton("Auto Observation Haki", "rbxassetid://7743872365", "Train Observation Haki")

-- Bottom Control Bar
local controlBar = Instance.new("Frame")
controlBar.Name = "ControlBar"
controlBar.Size = UDim2.new(1, -40, 0, 55)
controlBar.Position = UDim2.new(0, 20, 1, -70)
controlBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
controlBar.BorderSizePixel = 0
controlBar.Parent = mainFrame

local controlCorner = Instance.new("UICorner")
controlCorner.CornerRadius = UDim.new(0, 10)
controlCorner.Parent = controlBar

local controlLayout = Instance.new("UIListLayout")
controlLayout.FillDirection = Enum.FillDirection.Horizontal
controlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
controlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
controlLayout.Padding = UDim.new(0, 12)
controlLayout.Parent = controlBar

-- Function to create control button
local function createControlButton(name, iconId, color)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Button"
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = controlBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local btnIcon = Instance.new("ImageLabel")
    btnIcon.Size = UDim2.new(0, 20, 0, 20)
    btnIcon.Position = UDim2.new(0, 12, 0.5, -10)
    btnIcon.BackgroundTransparency = 1
    btnIcon.Image = iconId
    btnIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    btnIcon.Parent = btn
    
    local btnLabel = Instance.new("TextLabel")
    btnLabel.Size = UDim2.new(1, -40, 1, 0)
    btnLabel.Position = UDim2.new(0, 38, 0, 0)
    btnLabel.BackgroundTransparency = 1
    btnLabel.Text = name:upper()
    btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnLabel.Font = Enum.Font.GothamBold
    btnLabel.TextSize = 12
    btnLabel.TextXAlignment = Enum.TextXAlignment.Left
    btnLabel.Parent = btn
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.new(
            math.min(color.R + 0.1, 1),
            math.min(color.G + 0.1, 1),
            math.min(color.B + 0.1, 1)
        )
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color
    end)
    
    return btn
end

-- Create control buttons
local executeBtn = createControlButton("Execute All", "rbxassetid://7743866903", Color3.fromRGB(147, 112, 219))
local configBtn = createControlButton("Configs", "rbxassetid://7743869154", Color3.fromRGB(60, 60, 75))
local discordBtn = createControlButton("Discord", "rbxassetid://7743871002", Color3.fromRGB(88, 101, 242))

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

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
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

-- Button Actions
executeBtn.MouseButton1Click:Connect(function()
    print("Executing all enabled features...")
end)

configBtn.MouseButton1Click:Connect(function()
    print("Opening configs...")
end)

discordBtn.MouseButton1Click:Connect(function()
    print("Opening Discord...")
end)

print("✅ Blox Fruits Menu UI loaded successfully!")
