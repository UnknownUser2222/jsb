game.Players.PlayerAdded:Connect(function(plr)
	wait(2)
		 if plr.leaderstats.World.Value == 2 then
		 workspace.PartLock:Destroy()
	end
	if plr.leaderstats.World.Value == 3 then
		workspace.PartLock2:Destroy()
	end
		
	
end)