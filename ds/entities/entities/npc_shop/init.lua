AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.

function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	self:SetModel( "models/Humans/Group03/Male_05.mdl" ) -- Sets the model of the NPC.
	self:SetHullType( HULL_HUMAN ) -- Sets the hull type, used for movement calculations amongst other things.
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX ) -- This entity uses a solid bounding box for collisions.
	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD ) -- Adds what the NPC is allowed to do ( It cannot move in this case ).
	self:SetUseType( SIMPLE_USE ) -- Makes the ENT.Use hook only get called once at every use.
	self:DropToFloor()
	
	self:SetMaxYawSpeed( 90 ) --Sets the angle by which an NPC can rotate at once.
	
end




function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		umsg.Start("ShopNPCUsed", Caller) -- Prepare the usermessage to that same player to open the menu on his side.
		umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
	end
end

util.AddNetworkString("buy_gun")
util.AddNetworkString("buy_entity")
util.AddNetworkString("openshopmenu")

net.Receive("openshopmenu", function(len, ply)
		
end) 

net.Receive("buy_gun", function(len, ply) 
	local int = net.ReadInt(32)

	local gunTab = OWC.Config.SHOP.weaponsArr[int]
	local balance = ply:GetNWInt("playerMoney")
	local gunCost = tonumber(gunTab[4])
	local gun = gunTab[2]
   
	if (gunCost <= balance) then
		ply:SetNWInt("playerMoney", balance - gunCost)
		ply:Give(gun)
		ply:GiveAmmo(30, ply:GetWeapon(gun):GetPrimaryAmmoType(), false)
	end
end)

net.Receive("buy_entity", function(len, ply)
	local int = net.ReadInt(32)

	local entTab = OWC.Config.SHOP.entsArr[int]
	local balance = ply:GetNWInt("playerMoney")
	local entCost = tonumber(entTab[4])
	local ent = entTab[2]

	local SpawnPos = ply:GetShootPos() + ply:GetForward() *80
    local ent = ents.Create(ent)

    if (!IsValid(ent)) then return end
   
	if (entCost <= balance) then       
        ply:SetNWInt("playerMoney", balance - entCost)
        ent:SetPos(SpawnPos)
        ent:Spawn()
        ent:Activate()
    else
    	ent:Remove()
	end
end)