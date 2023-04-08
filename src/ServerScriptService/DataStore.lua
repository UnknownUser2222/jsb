local dataStoreService = game:GetService("DataStoreService")
local dataStore = dataStoreService:GetDataStore("Datastore_main")
warn("Multiple DataStores added, may cause potential errors. If you found one, please report it to @azgsuwiwgs.")
game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errormessage = pcall(function()
		data = dataStore:GetAsync(player.UserId.."-jumps")
	end)

	if success then
		print("Success")
		player.leaderstats.Jumps.Value = data
	else
		print("There was an error.")
		warn(errormessage)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
print("Player "..plr.UserId)
	local success, errormessage = pcall(function()
		dataStore:SetAsync(plr.UserId.."-jumps", plr.leaderstats.Jumps.Value)
	end)
    
	if success then
		print("Successfully saved Player Data!")
	else
		print("There was an error while saving player data!")
		warn(errormessage)
	end
	
end)

 local dataStore = dataStoreService:GetDataStore("Datastore_2")

game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errormessage = pcall(function()
		data = dataStore:GetAsync(player.UserId.."-worlds")
	end)

	if success then
		print("Success")
		player.leaderstats.World.Value = data
	else
		print("There was an error.")
		warn(errormessage)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	print("Player "..plr.UserId)
	local success, errormessage = pcall(function()
		dataStore:SetAsync(plr.UserId.."-worlds", plr.leaderstats.World.Value)
	end)

	if success then
		print("Successfully saved World Data!")
	else
		print("There was an error while saving world data!")
		warn(errormessage)
	end

end)


local dataStore = dataStoreService:GetDataStore("Datastore_3b")

game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errormessage = pcall(function()
		data = dataStore:GetAsync(player.UserId.."-forquests")
	end)

	if success then
		print("Success")
		player.forsaken.Quest.Value = data
	else
		print("There was an error.")
		warn(errormessage)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	print("Player "..plr.UserId)
	local success, errormessage = pcall(function()
		dataStore:SetAsync(plr.UserId.."-forquests", plr.forsaken.Quest.Value)
	end)

	if success then
		print("Successfully saved Quest Data!")
	else
		print("There was an error while saving quest data!")
		warn(errormessage)
	end

end)


local dataStore = dataStoreService:GetDataStore("Datastore_4b")

game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errormessage = pcall(function()
		data = dataStore:GetAsync(player.UserId.."-forcoins")
	end)

	if success then
		print("Success")
		player.forsaken.Coins.Value = data
	else
		print("There was an error.")
		warn(errormessage)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	print("Player "..plr.UserId)
	local success, errormessage = pcall(function()
		dataStore:SetAsync(plr.UserId.."-forcoins", plr.forsaken.Coins.Value)
	end)

	if success then
		print("Successfully saved Fcoins Data!")
	else
		print("There was an error while saving Fcoins data!")
		warn(errormessage)
	end

end)


local dataStore = dataStoreService:GetDataStore("Datastore_4b")

game.Players.PlayerAdded:Connect(function(player)
	local data
	local success, errormessage = pcall(function()
		data = dataStore:GetAsync(player.UserId.."-forworld")
	end)

	if success then
		print("Success")
		player.forsaken.World.Value = data
	else
		print("There was an error.")
		warn(errormessage)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	print("Player "..plr.UserId)
	local success, errormessage = pcall(function()
		dataStore:SetAsync(plr.UserId.."-forworld", plr.forsaken.World.Value)
	end)

	if success then
		print("Successfully saved Fworld Data!")
	else
		print("There was an error while saving Fworld data!")
		warn(errormessage)
	end

end)


-- Server
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local DSS = game:GetService("DataStoreService")

local TextBoxData = DSS:GetDataStore("__GUIUpgrade1Multi1")

Players.PlayerAdded:Connect(function(client)
	local Data

	local Success, Error = pcall(function()
		Data = TextBoxData:GetAsync(client.UserId)
	end)

	if Success and Data then
		RS.ChangeText1_1:FireClient(client, Data) -- Localize the textbox with your own path
	end
end)

RS.SaveText1_1.OnServerEvent:Connect(function(client, text)
	pcall(function()
		TextBoxData:SetAsync(client.UserId, text)
	end)
end)


local TextBoxData2 = DSS:GetDataStore("__GUIUpgrade1Multi2")

Players.PlayerAdded:Connect(function(client)
	local Data

	local Success, Error = pcall(function()
		Data = TextBoxData2:GetAsync(client.UserId)
	end)

	if Success and Data then
		RS.ChangeText1_2:FireClient(client, Data) -- Localize the textbox with your own path
	end
end)

RS.SaveText1_2.OnServerEvent:Connect(function(client, text)
	pcall(function()
		TextBoxData2:SetAsync(client.UserId, text)
	end)
end)