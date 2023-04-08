local prompt = workspace.PartA16.ProximityPrompt
local cache = 0

if cache > 5 then
	print("Quest ready")
	game.StarterGui:SetCore("ChatSystemMakeMessage", {
		Text = "[QUESTS] Forsaken Quest 2 Complete!",
		FontSize = Enum.FontSize.Size24,
		Color = Color3.new(1, 1, 0)
	})
end
local rep = game:GetService("ReplicatedStorage")
game.Players.PlayerAdded:Connect(function(plr)
	
	wait(5)
	prompt.Triggered:Connect(function(plr) 
		--[[if plr.forsaken.Quest.Value == 2 then
			local dialog = Instance.new("Dialog")
			dialog.Purpose = "Quest"
			dialog.Parent = workspace.Technoblade.Head
			dialog.InitialPrompt = "Hello there, do you need a quest?"
			local choice1 = Instance.new("DialogChoice")
			choice1.Parent = dialog
			choice1.UserDialog = "Yes"
			choice1.ResponseDialog = "Quest 3: Find an Forsaken teleport (in here)"
			
		end
		]]
		
	
		if plr.forsaken.Quest.Value == 1 then
		
		
		
		
		local dialog = Instance.new("Dialog")
		dialog.Purpose = "Quest"
		dialog.Parent = workspace.Technoblade.Head
		dialog.InitialPrompt = "Hello there, do you need a quest?"
		local choice1 = Instance.new("DialogChoice")
		choice1.Parent = dialog
		choice1.UserDialog = "Yes"
			choice1.ResponseDialog = "Quest 3: Jump 150 times"
			rep.RemoteEvents.HatchPet.OnServerEvent:Connect(function()
				cache += 1
			end)
			if cache > 5 then
				print("Quest ready")
				dialog:Destroy()
				local choice2 = Instance.new("Dialog")
				choice2.Parent = workspace.Technoblade.Head
				choice2.Purpose = "Quest"
				choice2.InitialPrompt = "You have completed the quest. Here is 30 Forsaken Coins. Come back anytime for a new quest. Code: 963085163"
				prompt.ObjectText = "View quest"
				prompt.ActionText = "Quest 3"
				plr.forsaken.Coins.Value += 30
				plr.forsaken.Quest.Value += 1;
			end
		
		if plr.forsaken.Quest.Value == 0 then

		prompt.ObjectText = "You found the forsaken"
		prompt.ActionText = "1B Jumps"

		prompt.KeyboardKeyCode = Enum.KeyCode.E
		prompt.RequiresLineOfSight = false
		prompt.MaxActivationDistance = 7
		prompt.HoldDuration = 10
		return 0 
		end return 0 
		end end)
	end)
	