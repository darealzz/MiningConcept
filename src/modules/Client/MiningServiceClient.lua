--[=[
	@class MiningServiceClient
]=]

local require = require(script.Parent.loader).load(script)

local MiningServiceClient = {}
MiningServiceClient.ServiceName = "MiningServiceClient"

function MiningServiceClient:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	-- External
	self._serviceBag:GetService(require("CmdrServiceClient"))

	-- Internal
	self._serviceBag:GetService(require("MiningTranslator"))
	self._serviceBag:GetService(require("BlockDestroyServiceClient"))
end

return MiningServiceClient
