game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		if humanoid then
			humanoid.Jumping:Connect(function()
				local multiStorage = require(script.Parent.ModuleScript)	
				if multiStorage.multi == 2 then
					print("Now jumping multiplication set to ".. multiStorage.multi)
				end
				player.leaderstats.Jumps.Value += multiStorage.multi 
					
			end)
		end
	end)
end)
