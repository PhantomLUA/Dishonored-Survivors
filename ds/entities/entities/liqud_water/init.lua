AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua')
util.AddNetworkString( "tree" )

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/props_junk/garbage_plasticbottle003a.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		Caller:SetNWInt("playerThirst", Caller:GetNWInt("playerThirst") + 35)
		if Caller:GetNWInt("playerThirst") >= 100 then Caller:SetNWInt("playerThirst", 100) end
		self:Remove()
	end
end
