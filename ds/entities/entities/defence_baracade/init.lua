AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/props_junk/TrashDumpster02b.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
	self:SetHealth(500)
end

function ENT:OnTakeDamage(damage)
	self:SetHealth(self:Health() - damage:GetDamage())
	
	if(self:Health() <= 0) then
		self:Remove()
	end
end