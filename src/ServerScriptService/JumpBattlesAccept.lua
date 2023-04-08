local event = game.ReplicatedStorage.JumpBattleAccept --You need to change this to the name of the RemoteEvent

event.OnServerEvent:Connect(function(plr)
	plr.Character:MoveTo(game.Workspace.Tele1.Position);
	local newlts = plr.leaderstats.Jumps.Value * 2;
	plr.leaderstats.Jumps.Value = newlts
	wait(1)
	plr.Character:MoveTo(game.Workspace.SpawnLocation.Position)
end)