SpawnPoints = {
	Vector(12811, -7883, -12979),
	Vector(11896, -8803, -13155),
	Vector(9891, -12949, -12960),
	Vector(10013, -12815, -13121),
	Vector(11184, 7926, -12982),
	Vector(8068, -4983, -12811),
	Vector(7330, -5116, -13138),
	Vector(5260, -5449, -13170),
	Vector(5309, -5505, -12853),
	Vector(4239, 7218, -12180),
	Vector(772, 11216, -13173),
	Vector(-1669, 14584, -12839),
	Vector(-4032, 13566, -13173),
	Vector(-3980, 14779, -13173),
	Vector(-7023, 14548, -13173),
	Vector(-13009, 1054, -12657),
	Vector(-14165, 1131, -12639),
	Vector(-10956, -8999, -13120),
	----
	Vector(-11408, -8655, -13155),
	Vector(-12896, -12219, -13131),
	Vector(-13568, -8999, -13126),
	Vector(-14356, -14434, -13126),
	Vector(12392, -12304, -13163),
	----
	Vector(659, 383, -12223)
}

Weapons = {
	"tfa_nmrih_hatchet",
	"cw_ak74",
	"junk_wood",
	"materials_box",
	"food_melon",
	"liqud_water",
	"food_melon",
	"liqud_water",
	"food_melon",
	"liqud_water",
	"cw_shorty",
	"tfa_nmrih_fubar",
	"tfa_nmrih_chainsaw",
	"cw_g4p_awm",
	"cw_g4p_glock17",
	"cw_ammo_kit_small",
	"item_healthkit",
	"cw_mr96"
}
Delay = 600 // Seconds
-------------------------------


sw_cooldown = CurTime()
function SpawnWeapons()
	if sw_cooldown < CurTime() then
		for k,v in pairs(SpawnPoints) do
			local wep = ents.Create(table.Random(Weapons))
			wep:SetPos(v)
			wep:Spawn()
		end
		sw_cooldown = CurTime() + Delay
	end
end
hook.Add("Think", "SpawnWeapons", SpawnWeapons)