-- Author: @Jumpathy
-- Name: EzWrapper.lua
-- Description: Automatically wraps every instance in the game for you!

local environment = {};
local signalModule = require(script:WaitForChild("signal"));
local functions,properties,signals = {},{},{};
local wrappedBehaviorInstances = {};
local base = {};
local rawRequire = require;

-- This makes sure require() works properly because if you pass a wrapped object, it'll error.

local pseudoRequire = function(to)
	if(type(to) == "number") then
		return rawRequire(to);
	else
		local object = (to:GetRaw());
		if(object == script) then
			return environment;
		else
			return rawRequire(object);
		end
	end
end

-- Replace all real instances in the passed table with wrapped instances.

local handleResponse = function(arguments)
	for key,value in pairs(arguments) do
		if(typeof(value) == "Instance") then
			arguments[key] = wrapInstance(value);
		end
	end
	return unpack(arguments);
end

-- For bindables internally (like .PlayerAdded) that fire with instances
-- this function converts the instances into wrapped objects so developers
-- don't need to wrap them manually.

local wrapSignal = function(indexed) -- avert your eyes pls <3
	local pseudo = {};
	local onConnection = function(callback)
		local rawConnection = indexed:Connect(function(...)
			callback(handleResponse({...}));
		end)

		local connection = {};

		function connection:Disconnect()
			rawConnection:Disconnect();
		end

		function connection:disconnect()
			rawConnection:Disconnect();
		end

		function connection:GetRaw()
			return rawConnection;
		end

		return connection;
	end
	function pseudo:Connect(callback)
		return onConnection(callback);
	end
	function pseudo:connect(callback)
		return onConnection(callback);
	end
	function pseudo:Wait()
		return handleResponse({indexed:Wait()});
	end
	function pseudo:wait()
		return pseudo:Wait();
	end
	return pseudo;
end

-- For functions that return data, this function will ensure all things returned are
-- wrapped nicely :D

local cleanse = function(args)
	for k1,response in pairs(args) do
		if(type(response) == "table") then
			for key,sub in pairs(response) do
				if(typeof(sub) == "Instance") then
					response[key] = wrapInstance(sub);
				elseif(typeof(sub) == "RBXScriptSignal") then
					args[k1] = wrapSignal(sub);
				end
			end
		elseif(typeof(response) == "RBXScriptSignal") then
			args[k1] = wrapSignal(response);
		elseif(typeof(response) == "Instance") then
			args[k1] = wrapInstance(response);
		end
	end
	return args;
end

-- For functions (ex: TweenService:Create) being passed a custom instance
-- this function will replace the custom instance internally so it's directly
-- passed instead of the developer needing to go ':GetRaw()' for each individual instance argument.

local uncleanse = function(args)
	for k1,response in pairs(args) do
		if(type(response) == "table") then
			if(response.IsCustom) then
				args[k1] = response:GetRaw();
			end
		end
	end
	return unpack(args);
end

-- This method is used to wrap instances so you can add custom methods, properties, and more!

wrapInstance = function(instance)
	if(wrappedBehaviorInstances[instance]) then
		return wrappedBehaviorInstances[instance];
	end

	local wrappedBehavior = {};
	wrappedBehavior.IsCustom = true;
	wrappedBehaviorInstances[instance] = wrappedBehavior;

	function wrappedBehavior:RefreshInternal() -- For base signals, properties, and functions this adds them to every instance
		for _,data in pairs(base) do
			if(data.class == "function") then
				wrappedBehavior:SetFunction(data.name,data.value,nil,true);
			elseif(data.class == "property") then
				wrappedBehavior:SetCustomProperty(data.name,data.value);
			elseif(data.class == "signal") then
				rawset(wrappedBehavior,data.name,data.value);
			end
		end
	end

	function wrappedBehavior:GetRaw()
		return instance;
	end

	function wrappedBehavior:GetCustomProperties()
		return properties[instance];
	end

	function wrappedBehavior:GetCustomFunctions()
		return functions[instance];
	end

	function wrappedBehavior:SetCustomProperty(name,value)
		properties[instance] = properties[instance] or {};
		properties[instance][name] = value;
		rawset(wrappedBehavior,name,value);
	end

	function wrappedBehavior:SetFunction(name,og,check,callWith)
		local callback = check and function(self,...)
			assert(self == wrappedBehavior,("Expected ':' not '.' calling member function %s"):format(name));
			return og(...);			
		end or og;
		if(callWith) then
			callback = function(...)
				og(wrappedBehavior,...);
			end
		end
		functions[instance] = functions[instance] or {};
		functions[instance][name] = callback;
		rawset(wrappedBehavior,name,callback);
	end

	function wrappedBehavior:NewSignal(name)
		local signal = signalModule.new();
		signals[instance] = signals[instance] or {};
		signals[instance][name] = signal;
		rawset(wrappedBehavior,name,signal);
		return signal;
	end

	function wrappedBehavior:GetSignal(name)
		return(signals[instance] or {})[name];
	end

	function wrappedBehavior:Destroy()
		local t1,t2 = functions[instance] or {},properties[instance] or {};
		for _,t in pairs({t1,t2}) do -- Remove properties
			for key,value in pairs(t) do
				--if(t == t3) then
					--value:DisconnectAll(); Removed because it'd remove global base signal callbacks if used
				--end
				t[key] = nil;
			end
		end
		instance:Destroy(); -- Real destroy
		wrappedBehaviorInstances[instance] = nil; -- Erase internally yk
	end

	setmetatable(wrappedBehavior,{
		__index = function(t,k) -- If it's not directly on the wrapped object, it'll check the real object
			local indexed = instance[k];
			if(typeof(indexed) == "Instance") then -- Something like .Parent
				return wrapInstance(indexed); -- Wrap it!
			elseif(typeof(indexed) == "RBXScriptSignal") then 
				-- To ensure everything is wrapped, I event connect to signals and if an instance is passed I wrap them
				return wrapSignal(indexed);
			elseif(typeof(indexed) == "function") then
				return function(self,...) -- When you call something like :FindFirstChild("Name") it's actually the same as .FindFirstChild(object,"Name") and this checks to make sure that it works properly
					assert(self == wrappedBehavior,("Expected ':' not '.' calling member function %s"):format(k));
					local handleReturn = function(...)
						return unpack(cleanse({indexed(instance,...)})); -- Call the function and wrap all the returned variables
					end
					return handleReturn(uncleanse({...})); -- If any wrapped objects are passed this will convert them back to regular objects so the method can be called
				end
			else
				return indexed; -- Boring, it's just like a string such as '.Name'
			end
		end,
		__newindex = function(t,k,v) -- This is to changing stuff like .Parent, .Name etc
			if(type(v) == "table") then -- If they're changing something like the '.Parent' this will ensure it's changed back to the real instance instead of a wrapped one
				v = v:GetRaw();
			end
			instance[k] = v; -- Set it actually (use rawset(table,key,value) if you want to directly set stuff to the wrapped object)
		end,
		__tostring = function() -- When printing the wrapped instance this will hide it from revealing it's an actual table
			return tostring(instance);
		end,
	})

	wrappedBehavior:RefreshInternal();
	return wrappedBehavior;
end

function environment:AddBaseFunction(name,callback)
	local toAdd = {
		class = "function",
		name = name,
		value = callback
	}
	table.insert(base,toAdd);
	for _,inst in pairs(wrappedBehaviorInstances) do
		inst:RefreshInternal();
	end
	return {
		Remove = function()
			table.remove(base,table.find(base,toAdd));
		end,
	}
end

function environment:AddBaseSignal(name)
	local signal = signalModule.new();
	local toAdd = {
		class = "signal",
		name = name,
		value = signal
	}
	table.insert(base,toAdd);
	for _,inst in pairs(wrappedBehaviorInstances) do
		inst:RefreshInternal();
	end
	return {
		Get = function()
			return signal;
		end,
		Remove = function()
			table.remove(base,table.find(base,toAdd));
		end,
	}
end

function environment:AddBaseCustomProperty(name,value)
	local toAdd = {
		class = "property",
		name = name,
		value = value
	}
	table.insert(base,toAdd);
	for _,inst in pairs(wrappedBehaviorInstances) do
		inst:RefreshInternal();
	end
	return {
		Remove = function()
			table.remove(base,table.find(base,toAdd));
		end,
	}
end

function environment.new(scr)
	-- Initializing variables

	scr = scr or  getfenv(2)["script"];
	local rawWorkspace = workspace;
	local rawGame = game;
	local rawInstance,instanceWrapper = Instance,{};

	-- Game wrapper
	
	local gameWrapper = wrapInstance(rawGame);
	
	-- Workspace wrapper

	local workspaceWrapper = wrapInstance(rawWorkspace);

	-- Script wrapper

	local scriptWrapper = wrapInstance(scr);

	-- Instance <class> wrapper:

	function instanceWrapper.new(className,parent)
		return wrapInstance(rawInstance.new(className,parent and parent:GetRaw()));
	end

	-- Return:

	return workspaceWrapper,gameWrapper,scriptWrapper,instanceWrapper;
end

-- This makes your code look cleaner and keep Intellisense but at a cost of micro-performance, but I'm not sure if
-- the difference is negligible due to all of the custom wrapping.

-- See: https://devforum.roblox.com/t/warnings-for-getfenvsetfenv-that-their-use-disables-luau-optimisations/1484260

function environment:Setup()
	local raw = getfenv(2);
	local workspaceWrapped,gameWrapped,scriptWrapped,instanceWrapped = environment.new(raw["script"]);
	for variable,value in pairs({
		["game"] = gameWrapped,
		["workspace"] = workspaceWrapped,
		["script"] = scriptWrapped,
		["Instance"] = instanceWrapped,
		["require"] = pseudoRequire
	}) do
		raw[variable] = value;
	end
end

return environment;