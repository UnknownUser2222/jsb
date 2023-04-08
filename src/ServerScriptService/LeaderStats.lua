local Players = game:GetService("Players")
local multi = require(script.Parent.ModuleScript)
local function leaderboardSetup(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Jumps = Instance.new("IntValue")
	Jumps.Name = "Jumps"
	Jumps.Value = 0
	Jumps.Parent = leaderstats
	local Worlds = Instance.new("IntValue")
    Worlds.Name = "World"
	Worlds.Value = 0
	Worlds.Parent = leaderstats
	
end

local function invLeaderboardSetup(player)
	local leaderstats2 = Instance.new("Folder")
	leaderstats2.Name = "forsaken"
	leaderstats2.Parent = player
	
	local UpgradesMultiJumps = Instance.new("IntValue")
	UpgradesMultiJumps.Name = "Coins"
	UpgradesMultiJumps.Value = 0
	UpgradesMultiJumps.Parent = leaderstats2
	
	local quests = Instance.new("IntValue")
	quests.Name = "Quest"
	quests.Value = 0
	quests.Parent = leaderstats2
	
	local world = Instance.new("IntValue")
	world.Name = "World"
	world.Value = 0
	world.Parent = leaderstats2
end

-- Connect the "leaderboardSetup()" function to the "PlayerAdded" event
Players.PlayerAdded:Connect(leaderboardSetup)
Players.PlayerAdded:Connect(invLeaderboardSetup)
