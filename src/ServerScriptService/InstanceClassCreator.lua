local new_instance = Instance.new
local custom_classes = game:GetService("ReplicatedStorage").CustomClasses
local Instance = {
	new = function(class_name, ...)
		if custom_classes:FindFirstChild(class_name) then
			return require(custom_classes[class_name]).new(...)
		end
		return new_instance(class_name)
	end
}


--local new = new_instance("pizza")
--new:Eat()
--print(new.Slices) -- 7
--new.Parent = game.StarterPlayer