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
title.Text = "𝐁𝐋𝐎𝐗 𝐅𝐑𝐔𝐈𝐓𝐒"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
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
tabsLayout.Padding = UDim.new(0, 8)
tabsLayout.Parent = tabsContainer

-- Current active tab
local currentTab = "𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦"

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
    tabBtn.TextSize = 13
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

-- Create tabs with Megapixel style text
createTabButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦")
createTabButton("𝐂𝐨𝐦𝐛𝐚𝐭")
createTabButton("𝐌𝐢𝐬𝐜")
createTabButton("𝐒𝐭𝐚𝐭𝐬")
createTabButton("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭")

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
contentFrames["𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦"] = createContentFrame("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦")
contentFrames["𝐂𝐨𝐦𝐛𝐚𝐭"] = createContentFrame("𝐂𝐨𝐦𝐛𝐚𝐭")
contentFrames["𝐌𝐢𝐬𝐜"] = createContentFrame("𝐌𝐢𝐬𝐜")
contentFrames["𝐒𝐭𝐚𝐭𝐬"] = createContentFrame("𝐒𝐭𝐚𝐭𝐬")
contentFrames["𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭"] = createContentFrame("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭")

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
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleBtn.Text = "𝐎𝐅𝐅"
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
            toggleBtn.Text = "𝐎𝐍"
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            print(name .. " enabled!")
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            toggleBtn.Text = "𝐎𝐅𝐅"
            toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            print(name .. " disabled!")
        end
    end)
    
    return featureFrame
end

-- Create features for Auto Farm tab
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦 𝐋𝐞𝐯𝐞𝐥", "Automatically farm enemies for levels")
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦 𝐌𝐚𝐬𝐭𝐞𝐫𝐲", "Farm weapon and fruit mastery")
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦 𝐁𝐨𝐬𝐬", "Automatically defeat bosses")
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦 𝐅𝐫𝐮𝐢𝐭", "Hunt for devil fruits")
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐐𝐮𝐞𝐬𝐭", "Complete quests automatically")
createFeatureButton("𝐀𝐮𝐭𝐨 𝐅𝐚𝐫𝐦", "𝐀𝐮𝐭𝐨 𝐎𝐛𝐬𝐞𝐫𝐯𝐚𝐭𝐢𝐨𝐧 𝐇𝐚𝐤𝐢", "Train Observation Haki")

-- Create features for Combat tab
createFeatureButton("𝐂𝐨𝐦𝐛𝐚𝐭", "𝐀𝐮𝐭𝐨 𝐂𝐨𝐦𝐛𝐚𝐭", "Automatically attack enemies")
createFeatureButton("𝐂𝐨𝐦𝐛𝐚𝐭", "𝐀𝐢𝐦𝐛𝐨𝐭", "Auto aim at targets")
createFeatureButton("𝐂𝐨𝐦𝐛𝐚𝐭", "𝐊𝐢𝐥𝐥 𝐀𝐮𝐫𝐚", "Attack nearby enemies")
createFeatureButton("𝐂𝐨𝐦𝐛𝐚𝐭", "𝐀𝐮𝐭𝐨 𝐒𝐤𝐢𝐥𝐥", "Automatically use skills")

-- Create features for Misc tab
createFeatureButton("𝐌𝐢𝐬𝐜", "𝐀𝐮𝐭𝐨 𝐂𝐨𝐥𝐥𝐞𝐜𝐭 𝐂𝐡𝐞𝐬𝐭𝐬", "Collect all chests automatically")
createFeatureButton("𝐌𝐢𝐬𝐜", "𝐍𝐨 𝐂𝐥𝐢𝐩", "Walk through walls")
createFeatureButton("𝐌𝐢𝐬𝐜", "𝐅𝐥𝐲", "Enable fly mode")
createFeatureButton("𝐌𝐢𝐬𝐜", "𝐒𝐩𝐞𝐞𝐝 𝐇𝐚𝐜𝐤", "Increase movement speed")

-- Create features for Stats tab
createFeatureButton("𝐒𝐭𝐚𝐭𝐬", "𝐀𝐮𝐭𝐨 𝐌𝐞𝐥𝐞𝐞", "Auto upgrade melee stats")
createFeatureButton("𝐒𝐭𝐚𝐭𝐬", "𝐀𝐮𝐭𝐨 𝐃𝐞𝐟𝐞𝐧𝐬𝐞", "Auto upgrade defense stats")
createFeatureButton("𝐒𝐭𝐚𝐭𝐬", "𝐀𝐮𝐭𝐨 𝐒𝐰𝐨𝐫𝐝", "Auto upgrade sword stats")
createFeatureButton("𝐒𝐭𝐚𝐭𝐬", "𝐀𝐮𝐭𝐨 𝐆𝐮𝐧", "Auto upgrade gun stats")

-- Create features for Teleport tab
createFeatureButton("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭", "𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭 𝐭𝐨 𝐒𝐞𝐚 𝟏", "Teleport to first sea")
createFeatureButton("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭", "𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭 𝐭𝐨 𝐒𝐞𝐚 𝟐", "Teleport to second sea")
createFeatureButton("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭", "𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭 𝐭𝐨 𝐒𝐞𝐚 𝟑", "Teleport to third sea")
createFeatureButton("𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭", "𝐓𝐞𝐥𝐞𝐩𝐨𝐫𝐭 𝐭𝐨 𝐒𝐡𝐨𝐩", "Teleport to shop")

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
