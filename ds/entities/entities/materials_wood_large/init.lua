AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include('shared.lua')
util.AddNetworkString( "tree" )

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/props/cs_militia/logpile2.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:DropToFloor()
	self:SetHealth(30)
end

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		Caller:SetNWInt("playerWood", Caller:GetNWInt("playerMaterials") + math.random(20,50))
		self:Remove()
	end
end

function ENT:Think()

end

function ENT:OnTakeDamage(damage)
	self:SetHealth(self:Health() - damage:GetDamage())
	
	net.Receive( "tree", function( len, ply )
		ply:SetNWInt("playerWood", ply:GetNWInt("playerWood") + .5)
	end )
	
	if(self:Health() <= 0) then
		self:Remove()
	end
end