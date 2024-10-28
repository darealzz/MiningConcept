--[[
	@class ServerMain
]]
local ServerScriptService = game:GetService("ServerScriptService")

local loader = ServerScriptService.Mining:FindFirstChild("LoaderUtils", true).Parent
local require = require(loader).bootstrapGame(ServerScriptService.Mining)

local serviceBag = require("ServiceBag").new()
serviceBag:GetService(require("MiningService"))
serviceBag:Init()
serviceBag:Start()