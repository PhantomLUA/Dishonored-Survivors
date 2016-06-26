surface.CreateFont( "HUDFont-Ammo", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 40,
	weight = 750,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = true,
	outline = true,
} )
surface.CreateFont( "HUDFont-Name", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 25,
	weight = 750,
	blursize = 0.2,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = true,
	outline = false,
} )
surface.CreateFont( "HUDFont-Extra", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 30,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = true,
	outline = true,
} )

function HUD()
	local client = LocalPlayer()

	if !client:Alive() then
		return
	end

	draw.RoundedBox(2, 99, ScrH() - 60, math.Clamp(client:GetNWInt("Stamina"), 0, 100) * 2.2, 5, Color(255, 255, 255, 140))
	draw.RoundedBox(2, 99, ScrH() - 60, 100 * 2.2, 5, Color(255, 255, 255, 135))
	draw.RoundedBox(4, 50, ScrH() - 65, 275, 45, Color(40, 40, 40, 100))
	draw.RoundedBox(4, ScrW() - 193.5, ScrH() - 64, 135, 50, Color(40, 40, 40, 100))
	local SilkIconHeart= Material("icons/plus.png")
	surface.SetMaterial(SilkIconHeart)
	if client:Health() > 75 then 
	surface.SetDrawColor(255,255,255,165)
	elseif client:Health() > 40 then
	surface.SetDrawColor(120,255,120,165)
	else
	surface.SetDrawColor(255,0,0,165)
	end
	surface.DrawTexturedRect( ScrW() - 145, ScrH() - 57.5, 40,40)
	local Water= Material("icons/drop.png")
	surface.SetMaterial(Water)
    if client:GetNWInt("playerThirst") > 75 then 
	surface.SetDrawColor(255,255,255,165)
	elseif client:GetNWInt("playerThirst") > 40 then
	surface.SetDrawColor(120,255,120,165)
	else
	surface.SetDrawColor(255,0,0,165)
	end
	surface.DrawTexturedRect( ScrW() - 190, ScrH() - 57.5, 40,40)
	local Food= Material("icons/knife-and-fork.png")
	surface.SetMaterial(Food)
    if client:GetNWInt("playerHunger") > 75 then 
	surface.SetDrawColor(255,255,255,165)
	elseif client:GetNWInt("playerHunger") > 40 then
	surface.SetDrawColor(120,255,120,165)
	else
	surface.SetDrawColor(255,0,0,165)
	end
	surface.DrawTexturedRect( ScrW() - 100, ScrH() - 57.5, 40,40)
	
	net.Receive("notifi", function(len,ply)
		draw.SimpleText("You earned 200XP and $200","DermaDefaultBold", ScrW()-75,ScrH()-60 )
	end)
	
	if (key == IN_SPEED or ply:KeyDown(IN_SPEED)) then 
	local Run= Material("icons/man-sprinting.png")
	surface.SetMaterial(Run)
    surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect( 55, ScrH() - 61.5, 40,40)
	else
	local Walk= Material("icons/pedestrian-walking.png")
	surface.SetMaterial(Walk)
    surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect( 55, ScrH() - 61.5, 40,40)
		
end
	if(client:GetActiveWeapon():IsValid()) then  
	
		if(client:GetActiveWeapon():Clip1() != -1) then
			draw.SimpleText(client:GetActiveWeapon():Clip1().."/"..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "DermaDefaultBold", 100, ScrH() - 45, Color(255,255,255,85))
		end
	end
end
hook.Add("HUDPaint", "TestHud", HUD)



function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)
