OWC.Config.SHOP = OWC.Config.SHOP or {}
Craft = Craft or {}
--ENTITY Shop
OWC.Config.SHOP.entsArr = OWC.Config.SHOP.entsArr or {}
--entsArr[# in order (ex. [1], then [2], and so on)] = {"model", "weapon's/ents folder name (found in qmenu and copying to clipboard)", "name", "cost"}
OWC.Config.SHOP.entsArr[1] = {"models/Items/BoxSRounds.mdl", "cw_ammo_kit_small", "Small Ammo Kit", "250"}
OWC.Config.SHOP.entsArr[2] = {"models/props_junk/wood_crate001a_damaged.mdl", "materials_box", "Materials Box", "450"}
OWC.Config.SHOP.entsArr[3] = {"models/props_junk/wood_crate001a_damaged.mdl", "materials_box_large", "Large Materials Box", "1050"}
OWC.Config.SHOP.entsArr[4] = {"models/props_debris/wood_board06a.mdl", "junk_wood", "Wood", "150"}
OWC.Config.SHOP.entsArr[5] = {"models/props/cs_militia/logpile2.mdl", "materials_wood_large", "Large Wood Pile", "1550"}
OWC.Config.SHOP.entsArr[6] = {"models/props_junk/garbage_plasticbottle003a.mdl", "liqud_water", "Water", "750"}
OWC.Config.SHOP.entsArr[7] = {"models/props_junk/watermelon01.mdl", "food_melon", "Melon", "450"}


--WEAPON Shop
--weaponsArr[# in order (ex. [1], then [2], and so on)] = {"model", "weapon's/ents folder name (found in qmenu and copying to clipboard)", "name", "cost"}
OWC.Config.SHOP.weaponsArr = OWC.Config.SHOP.weaponsArr or {}
OWC.Config.SHOP.weaponsArr[1] = {"models/weapons/w_rif_ak47.mdl", "cw_ak74", "AK-74", "1000"}
OWC.Config.SHOP.weaponsArr[2] = {"models/weapons/w_pist_deagle.mdl", "cw_deagle", "Deagle", "450"}
OWC.Config.SHOP.weaponsArr[3] = {"models/weapons/w_cstm_l96.mdl", "cw_l115", "L115", "1250"}
OWC.Config.SHOP.weaponsArr[4] = {"models/weapons/w_smg_mp5.mdl", "cw_mp5", "MP5", "750"}
OWC.Config.SHOP.weaponsArr[5] = {"models/weapons/w_snip_g3sg1.mdl", "cw_g3a3", "G3A3", "1125"}
OWC.Config.SHOP.weaponsArr[6] = {"models/weapons/w_eq_smokegrenade.mdl", "cw_smoke_grenade", "Smoke Grenade", "250"}
OWC.Config.SHOP.weaponsArr[7] = {"models/weapons/w_rif_m4a1.mdl", "cw_ar15", "AR-15", "1300"}
OWC.Config.SHOP.weaponsArr[8] = {"models/weapons/w_eq_smokegrenade.mdl", "cw_frag_grenade", "Grenade", "550"}
OWC.Config.SHOP.weaponsArr[9] = {"models/weapons/w_pist_deagle.mdl", "cw_g4p_usp40", "USP", "500"}
OWC.Config.SHOP.weaponsArr[10] = {"models/weapons/w_cstm_m3super90.mdl", "cw_m3super90", "M3 Super 90", "1350"}
OWC.Config.SHOP.weaponsArr[11] = {"models/weapons/w_cstm_m14.mdl", "cw_m14", "M14", "1100"}
OWC.Config.SHOP.weaponsArr[12] = {"models/weapons/w_cst_mac11.mdl", "cw_mac11", "MAC11", "900"}
OWC.Config.SHOP.weaponsArr[12] = {"", "tfbow_crybow", "Compound Bow", "900"}



--Weapon CRAFTING
Craft.weaponsArr = Craft.weaponsArr or {}
--Craft.weaponsArr[1] = {"","","","","","",""}
Craft.weaponsArr[1] = {"models/weapons/w_cst_mac11.mdl","cw_mac11","MAC-11","25","0",}
Craft.weaponsArr[2] = {"models/weapons/w_crowbar.mdl","weapon_crowbar","Crowbar","15","0"}
Craft.weaponsArr[3] = {"models/weapons/w_physcannon.mdl","weapon_physcannon","Gravitiy Gun","45","0"}



--ENTITY CRAFTING
Craft.entsArr = Craft.entsArr or {}
--Craft.entsArr[1] = {"","","","",""}
Craft.entsArr[1] = {"models/props_unique/wooden_barricade.mdl","defence_baracade","Barricade/Wall","25","75"}
Craft.entsArr[2] = {"models/props/de_nuke/hr_nuke/signs/sign_fire_ladder_002_small.mdl","sent_vj_fireplace","Campfire","10","15"}
Craft.entsArr[3] = {"models/Items/BoxSRounds.mdl", "cw_ammo_kit_small", "Small Ammo Kit", "20","0"}

OWC.Config.DisabledModules = {
	["nope"] = true
}

CUI = {}

-- The Distance you have to be from somebody to see their info above their head
CUI.headinfodistance = 260

-- Should we tell the user they are cloaked? (ULX)
CUI.showiscloaked = true