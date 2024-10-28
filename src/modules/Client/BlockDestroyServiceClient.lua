--[=[
	@class BlockDestroyService
]=]

local Players = game:GetService("Players")
local require = require(script.Parent.loader).load(script)

local Remoting = require("Remoting")
local ValueObject = require("ValueObject")

local MiningService = {}
MiningService.ServiceName = "MiningService"

function MiningService:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	self._mouse = Players.LocalPlayer:GetMouse()
	self._miningRemotes = Remoting.new(workspace, "Mining")
	self._miningRemotes:DeclareEvent("BlockClicked")
	self._currentPart = ValueObject.new()
	self._highlight = Instance.new("SelectionBox")
	self._highlight.Color3 = Color3.new(0, 0, 0)
	self._highlight.SurfaceColor3 = Color3.fromRGB(172, 172, 172)
	self._highlight.SurfaceTransparency = 0.5
	self._highlight.LineThickness = 0.025
	self._highlight.Parent = workspace

	-- Internal
	-- self._layerBinder = self._serviceBag:GetService(require("Layer"))
	-- self._serviceBag:GetService(require("Block"))
end

function MiningService:Start()
	self._mouse.Button1Down:Connect(function()
		if self._mouse.Target and self._mouse.Target.Parent then
			self._mouse.Target.BrickColor = BrickColor.random()
			self._miningRemotes:FireServer("BlockClicked", self._mouse.Target)
		end
	end)

	self._mouse.Move:Connect(function()
		if self._mouse.Target and self._mouse.Target.Parent then
			self._highlight.Adornee = self._mouse.Target
		else
			self._highlight.Adornee = nil
		end
	end)
end

return MiningService
