AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua')
util.AddNetworkString( "tree" )

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/props_debris/wood_board06a.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		Caller:SetNWInt("playerWood", Caller:GetNWInt("playerWood") + math.random(2,5))
		self:Remove()
	end
end
