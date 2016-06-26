AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/props_junk/wood_crate002a.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		
		Caller:SetNWInt("playerMaterials", Caller:GetNWInt("playerMaterials") + math.random(8,15))
		Caller:SetNWInt("playerMetal", Caller:GetNWInt("playerMetal") + math.random(5,10))
		Caller:SetNWInt("playerPlastic", Caller:GetNWInt("playerPlastic") + math.random(1,5))
		self:Remove()
	end
end