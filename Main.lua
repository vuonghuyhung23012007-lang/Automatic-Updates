local LoadingTime = tick()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vuonghuyhung23012007-lang/Automatic-Updates/refs/heads/main/Src"))()
local Window = Library:CreateWindow({Credit = "pindummy"})
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
	Value = false,
	Callback = function(vu)
		
	end})
Page1:CreateDropdown("Right",{
	Title = "Weapon",
	Desc = "Select Weapon Farm",
	ListDesc = "Select Weapon To Farm",
	Value = "Melee",
	List = {"Melee", "Sword", "Power Fruit"},
	MultiDropdown = false,
	Callback = function(vu)
			
	end})
Page1:CreateSlider("Right",{
	Title = 'Distance',
	Desc = "Setup Distance",
	Min = 1,
	Max = 20,
	Value = 20,
	Callback = function(vu)
	
	end})
Page1:CreateLabel("Right", {
	Title = " - Setting Skill",
	Desc = "Select Skill To Use Farm"
})
Page1:CreateButton("r",{
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
	end})
