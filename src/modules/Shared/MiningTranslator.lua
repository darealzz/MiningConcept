--[[
	@class MiningTranslator
]]

local require = require(script.Parent.loader).load(script)

return require("JSONTranslator").new("MiningTranslator", "en", {
	gameName = "Mining";
})