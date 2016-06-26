ENT.Base = "base_ai"
ENT.PrintName		= "Shop"
ENT.Author			= "WolfLUA'"
ENT.Category		= "OWC"
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true 
 
function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:SetupDataTables()
	-- Model of the vendor
	self.model = "Models/CODMW2/T_CODMW2H.mdl"
	-- Name of the vendor
	self.name = "Military Dealer"
end