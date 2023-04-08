local module = {}

module.multi = 1
module.multi2 = 1

game.ReplicatedStorage.MultiJumpsValue.OnServerEvent:Connect(function()
	if module.multi2 == 1 then
		module.multi2 = 2
		module.multi = 3
		return module
	end
	if module.multi2 == 2 then
		module.multi2 = 3
		module.multi = 6
		return module
	end
	if module.multi2 == 3 then
		module.multi2 = 4
		module.multi = 12
		return module
	end
	if module.multi2 == 4 then
		module.multi2 = 5
		module.multi = 28
		return module
	end
	if module.multi2 == 5 then
		module.multi2 = 6
		module.multi = 68
		return module
	end
	if module.multi2 == 6 then
		module.multi2 = 7
		module.multi = 83
		return module
	end
	if module.multi2 == 7 then
		module.multi2 = 8
		module.multi = 99
		return module
	end
	if module.multi2 == 8 then
		module.multi2 = 9
		module.multi = 114
		return module
	end
end)

return module
