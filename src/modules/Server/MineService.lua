--[=[
	@class MineService
]=]

local ServerStorage = game:GetService("ServerStorage")
local require = require(script.Parent.loader).load(script)

local Remoting = require("Remoting")

local Template = ServerStorage.Template

local MiningService = {}
MiningService.ServiceName = "MiningService"

function MiningService:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	-- Internal
	self._layerBinder = self._serviceBag:GetService(require("Layer"))
	self._miningRemotes = Remoting.new(workspace, "Mining")
	self._miningRemotes:DeclareEvent("BlockClicked")

	self._currentLayer = -1
end

function MiningService:Start()
	self._layerBinder:ObserveAllBrio():Subscribe(function(classBrio)
		self._currentLayer += 1
		local class = classBrio:GetValue()
		class.BlockBroken:Connect(function()
			self:ReplicateLayerBellow(self._currentLayer)
		end)
	end)

	self._miningRemotes:Connect("BlockClicked", function(_, block)
		block:Destroy()
	end)
end

function MiningService:ReplicateLayerBellow(multiply)
	local obj = Template:Clone()
	obj:TranslateBy(Vector3.new(0, -obj.PrimaryPart.Size.Y * multiply, 0))
	obj.Parent = workspace
end

return MiningService
