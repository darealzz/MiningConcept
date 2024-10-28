--[=[
    @class Component
]=]

local require = require(script.Parent.loader).load(script)

local BaseObject = require("BaseObject")
local Binder = require("Binder")

local Component = setmetatable({}, BaseObject)
Component.ClassName = script.Name
Component.__index = Component

function Component.new(obj, serviceBag)
	local self = setmetatable(BaseObject.new(obj), Component)

	self._serviceBag = assert(serviceBag, "No serviceBag")
	-- self._cameraStackService = self._serviceBag:GetService(require("CameraStackService"))

	-- local SelectionBox = self._maid:Add(Instance.new("SelectionBox"))
	-- SelectionBox.Color3 = Color3.new(math.random(0, 1), math.random(0, 1), math.random(0, 1))
	-- SelectionBox.Adornee = self._obj
	-- SelectionBox.Parent = self._obj

	return self
end

return Binder.new(script.Name, Component)
