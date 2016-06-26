ENT.PrintName		= "Water"
ENT.Author			= "WolfLUA"
ENT.Category		= "OWC"
ENT.AutomaticFrameAdvance = true 
ENT.Type = "anim"

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
