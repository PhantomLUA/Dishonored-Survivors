local Menu = nil
-------------------------------------------------------------------------------------------------------------------------------------------
function GM:ScoreboardShow()
 if !IsValid(Menu)then
 	 Menu = vgui.Create( "DFrame" )
	 Menu:SetPos( ScrW()/4, ScrH()/6)
 	 Menu:SetSize(750, 500)
 	 Menu:SetTitle("")
 	 Menu:SetDraggable(false)
 	 Menu:ShowCloseButton(false)
 	 Menu:SetDeleteOnClose(false)
 	 Menu.Paint = function()
 	     surface.SetDrawColor(145, 145, 145, 250)
 	     surface.DrawRect(0,0,Menu:GetWide(),Menu:GetTall())
		 draw.SimpleText(os.date( "%a, %I:%M:%S %p" ), "DermaDefaultBold", 635, 2.5, Color( 255, 255, 255, 255 ),0,0)
 	   end
	 end
	PropertySheet(Menu)
	if IsValid(Menu) then 
		PlayerList:Clear()
		
		for k,v in pairs(player.GetAll()) do
			local PlayerPanels = vgui.Create("DPanel", PlayerList)
			PlayerPanels:SetSize(PlayerList:GetWide(), 50)
			PlayerPanels:SetPos(0,0)
			if !(v:GetName() and v:GetNWInt("playerMoney") == nil) then
			PlayerPanels.Paint = function()
				draw.RoundedBox(0,0,0,PlayerPanels:GetWide(), PlayerPanels:GetTall(), Color(75,75,75,255))
				draw.RoundedBox(0,0,49,PlayerPanels:GetWide(), 1, Color(255,255,255,255))
				draw.SimpleText("$"..v:GetNWInt("playerMoney").."       ".."Player Materials: "..v:GetNWInt("playerMaterials").."       ".."Player Wood: "..v:GetNWInt("playerWood"),"DermaDefault",20,25,Color(255,255,255))
				draw.SimpleText(v:GetName().."- Level "..v:GetNWInt("playerLvl"), "DermaDefault",20,10,Color(255,255,255,255))
			end
			else
			return end
		end
		Menu:Show()
		Menu:MakePopup()
		Menu:SetKeyboardInputEnabled(false)
	end    
end
-------------------------------------------------------------------------------------------------------------------------------------------
function GM:ScoreboardHide()
	if IsValid(Menu) then
	Menu:Hide()
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------
function PropertySheet(Menu)
local tabs = vgui.Create( "DPropertySheet", Menu )

tabs:SetPos(0,0)
tabs:SetSize( 750,500)
local InventoryPanel = vgui.Create( "DPanel" )
InventoryPanel:SetSize(750, 500)
InventoryPanel:SetPos(0, 0)
		InventoryPanel.Paint = function()
			surface.SetDrawColor(255,255,255,255)
			surface.DrawRect(0,0,InventoryPanel:GetWide(), InventoryPanel:GetTall())
			
			surface.SetTextColor(40,40,40,223)
			surface.CreateFont("InvFont", {font="Default", size=45, weight=5000})
			surface.SetFont("InvFont")
			surface.SetTextPos(5,0)
			surface.DrawText("Materials: " .. LocalPlayer():GetNWInt("playerMaterials"))
		
			surface.SetTextPos(5,35)
			surface.DrawText("Wood: " .. LocalPlayer():GetNWInt("playerWood"))
			
			surface.SetTextPos(5,70)
			surface.DrawText("Metal: " .. LocalPlayer():GetNWInt("playerMetal"))
			
			surface.SetTextPos(5,105)
			surface.DrawText("Plastic: " .. LocalPlayer():GetNWInt("playerPlastic"))
	end


local CraftingPanel = vgui.Create( "DPanel" )
CraftingPanel:SetSize(750, 500)
CraftingPanel:SetPos(0, 0)
	local entityCatergory = vgui.Create("DCollapsibleCategory", CraftingPanel)
	entityCatergory:SetPos(0,0)
	entityCatergory:SetSize(CraftingPanel:GetWide(), 100)
	entityCatergory:SetLabel("Entities")
	
	local weaponCatergory = vgui.Create("DCollapsibleCategory", CraftingPanel)
	weaponCatergory:SetPos(0,200)
	weaponCatergory:SetSize(CraftingPanel:GetWide(), 100)
	weaponCatergory:SetLabel("Weapons")
	
	local entityList = vgui.Create("DIconLayout", entityCatergory)
	entityList:SetPos(0,30)
	entityList:SetSize(entityCatergory:GetWide(), entityCatergory:GetTall())
	entityList:SetSpaceY(5)
	entityList:SetSpaceX(5)
	
	local weaponList = vgui.Create("DIconLayout", weaponCatergory)
	weaponList:SetPos(0,30)
	weaponList:SetSize(weaponCatergory:GetWide(), weaponCatergory:GetTall())
	weaponList:SetSpaceY(5)
	weaponList:SetSpaceX(5)
	
	
	for k,v in pairs(Craft.entsArr)do
		local icon = vgui.Create("SpawnIcon", entityList)
		icon:SetModel(v[1])
		icon:SetToolTip(v[3].."\nMaterials Needed: "..v[4].."\nWood Needed: "..v[5])
		entityList:Add(icon)
		icon.DoClick = function(icon)
			net.Start("craft_entity")
				net.WriteInt(k,32)
			net.SendToServer()
		end
	end
	
	for k,v in pairs(Craft.weaponsArr)do
		local icon = vgui.Create("SpawnIcon", weaponList)
		icon:SetModel(v[1])
		icon:SetToolTip(v[3].."\nMaterials Needed: "..v[4].."\nWood Needed: "..v[5])
		weaponList:Add(icon)
		icon.DoClick = function(icon)
			net.Start("craft_gun")
				net.WriteInt(k,32)
			net.SendToServer()
		end
	end

local ScoreboardPanel = vgui.Create( "DPanel" )
ScoreboardPanel:SetSize(750, 500)
ScoreboardPanel:SetPos(0, 0)
local PSP = vgui.Create("DScrollPanel", ScoreboardPanel)
PSP:SetSize(ScoreboardPanel:GetWide(), ScoreboardPanel:GetWide())
PSP:SetPos(0,0)

PlayerList = vgui.Create("DListLayout", PSP)
PlayerList:SetSize(PSP:GetWide(), PSP:GetWide())
PlayerList:SetPos(0,0)

tabs:AddSheet( "Crafting", CraftingPanel, "icon16/cog.png", false, false, "Crafting" )
tabs:AddSheet( "Inventory", InventoryPanel, "icon16/box.png", false, false, "Inventory" )
tabs:AddSheet( "Player Stats", ScoreboardPanel, "icon16/group.png", false, false, "Scoreboard" )
end
-------------------------------------------------------------------------------------------------------------------------------------------
 
PANEL = {} -- Create an empty panel
 
function PANEL:Init() --Initialize the panel
    self:SetSize(550, 475)
    self:SetPos(100, 25)
end
 
function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
end
 
vgui.Register("ScoreboardPanel", PANEL, "Panel")

PANEL = {} 

function PANEL:Init()
    self:SetSize(550, 475)
    self:SetPos(100, 25)
end
 
function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
end
 
vgui.Register("ScoreboardPanel", PANEL, "Panel")

 
PANEL = {} -- Create an empty panel
 
function PANEL:Init() --Initialize the panel
    self:SetSize(550, 475)
    self:SetPos(100, 25)
end
 
function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
end
 
vgui.Register("CraftingPanel", PANEL, "Panel")

