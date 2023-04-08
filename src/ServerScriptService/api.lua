local api = {
	getPlayerAttributes = function(dir)
	if dir == "plr/muliplier" then
			local text = game.StarterGui.ScreenGui.ShopFrame.Upgrade1.TextLabel2
		    return text.Text
		end
		
	end,
	getPlayerFromId = function(UserId)
		local PlayerNameFromId = game.Players:GetNameFromUserIdAsync(UserId)
		return PlayerNameFromId
	end,
	player = function()
	 local player = game.Players.LocalPlayer;
	local apiVersion = "1.06.1"
}





function api.playerScripts:KickPlayer(player, message)
	game.Players.PlayerAdded:Connect(function(plr)
		if plr.Name == player then
			plr:Kick(message)
			
			return print("Kicked player "..player.Name)
		end
	end)
end
function api:Suspend(sec)
	wait(sec)
end
function api:ConnectScript(ScriptConnection)
	local function Function()
		ScriptConnection();
	end
	Function();
end

return api