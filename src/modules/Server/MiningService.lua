--[=[
	@class MiningService
]=]

local require = require(script.Parent.loader).load(script)

local MiningService = {}
MiningService.ServiceName = "MiningService"

function MiningService:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	-- External
	self._serviceBag:GetService(require("CmdrService"))

	-- Internal
	self._serviceBag:GetService(require("MiningTranslator"))
	self._serviceBag:GetService(require("Block"))
	self._serviceBag:GetService(require("Layer"))
	self._serviceBag:GetService(require("MineService"))
end

return MiningService
