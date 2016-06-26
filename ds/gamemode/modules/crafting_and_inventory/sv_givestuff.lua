util.AddNetworkString("craft_gun")
util.AddNetworkString("craft_entity")
util.AddNetworkString("add_health")


/*/ Saved for later
net.Receive("add_health", function(len,ply)
	if ply:GetNWInt("upgradeHealth") >= 5 then 
	ply:SetNWInt("playerLvlPoints", ply:GetNWInt("playerLvlPoints") + 1)
	ply:SetNWInt("upgradeHealth", 1) 
	end
	if !ply:GetNWInt("playerLvlPoints") >= 1 then
	ply:SetNWInt("upgradeHealth", ply:GetNWInt("upgradeHealth") + .2)
	ply:SetHealth(ply:Health() + (ply:Health() * ply:GetNWInt("upgradeHealth")))
	else
	ply:ChatPrint("You don't have enough Upgrade Points") return end
end)/*/

net.Receive("craft_gun", function(len, ply) 
	local int = net.ReadInt(32)

	local gunTab = Craft.weaponsArr[int]
	local materials = ply:GetNWInt("playerMaterials")
	local matNeeded = tonumber(gunTab[4])
	local wood = ply:GetNWInt("playerWood")
	local woodNeeded = tonumber(gunTab[5])
	local plastic = ply:GetNWInt("playerPlastic")
	local metal = ply:GetNWInt("playerMetal")
	local plaNeeded = tonumber(gunTab[6])
	local metalNeeded = tonumber(gunTab[7])
	local gun = gunTab[2]
   
	if (matNeeded <= materials and woodNeeded <= wood) then
		ply:SetNWInt("playerMaterials", materials - matNeeded)
		ply:SetNWInt("playerWood", wood - woodNeeded)
		ply:Give(gun)
	end
end)

net.Receive("craft_entity", function(len, ply)
	local int = net.ReadInt(32)

	local entTab = Craft.entsArr[int]
	local materials = ply:GetNWInt("playerMaterials")
	local wood = ply:GetNWInt("playerWood")
	local matNeeded = tonumber(entTab[4])
	local woodNeeded = tonumber(entTab[5])
	local plastic = ply:GetNWInt("playerPlastic")
	local metal = ply:GetNWInt("playerMetal")
	local plaNeeded = tonumber(entTab[6])
	local metalNeeded = tonumber(entTab[7])
	local ent = entTab[2]
	
	local SpawnPos = ply:GetShootPos() + ply:GetForward() *80
    local ent = ents.Create(ent)

    if (!IsValid(ent)) then return end
   
	if (matNeeded <= materials and woodNeeded <= wood) then      
        ply:SetNWInt("playerMaterials", materials - matNeeded)
		ply:SetNWInt("playerWood", wood - woodNeeded)
        ent:SetPos(SpawnPos)
        ent:Spawn()
        ent:Activate()
    else
    	ent:Remove()
	end
end)