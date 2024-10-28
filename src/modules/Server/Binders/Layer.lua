--[=[
    @class Component
]=]

local require = require(script.Parent.loader).load(script)

local BaseObject = require("BaseObject")
local Binder = require("Binder")
local Signal = require("Signal")
local RxInstanceUtils = require("RxInstanceUtils")
local Maid = require("Maid")

local Component = setmetatable({}, BaseObject)
Component.ClassName = script.Name
Component.__index = Component

function Component.new(obj, serviceBag)
	local self = setmetatable(BaseObject.new(obj), Component)

	self._serviceBag = assert(serviceBag, "No serviceBag")
	local innerMaid = Maid.new()

	self.BlockBroken = innerMaid:Add(Signal.new())
	innerMaid:GiveTask(RxInstanceUtils.observeChildrenBrio(self._obj):Subscribe(function(partBrio)
		innerMaid:GiveTask(partBrio:GetDiedSignal():Connect(function()
			self.BlockBroken:Fire()
			innerMaid:DoCleaning()
		end))
	end))

	return self
end

return Binder.new(script.Name, Component)
