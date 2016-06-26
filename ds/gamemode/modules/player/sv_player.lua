util.AddNetworkString( "KEY_T" )

function GM:PlayerInitialSpawn(ply)
	ply:SetModel("models/player/Group03/male_08.mdl")
	if (ply:GetPData("playerLvl") == nil)then
		ply:SetNWInt("playerLvl", 1)
	else
		ply:SetNWInt("playerLvl", tonumber(ply:GetPData("playerLvl")))
		
		if (ply:GetPData("playerXp") == nil)then
			ply:SetNWInt("playerXp", 0)
		else
			ply:SetNWInt("playerXp", tonumber(ply:GetPData("playerXp")))
			
			if (ply:GetPData("playerMoney") == nil)then
				ply:SetNWInt("playerMoney", 1500)
			else
				ply:SetNWInt("playerMoney", tonumber(ply:GetPData("playerMoney")))
				
				if (ply:GetPData("playerMaterials") == nil)then
					ply:SetNWInt("playerMaterials", 0)
				else
					ply:SetNWInt("playerMaterials", tonumber(ply:GetPData("playerMaterials")))
					end
				end
			end
		end
	end
util.AddNetworkString( "hunger" )
util.AddNetworkString( "notifi" )

local DefaultRunSpeed		= 240	
local DefaultWalkSpeed		= 150	
local DefaultJumpPower		= 250

local DisableLevel			= 10	

local StaminaDrainSpeed 	= 0.1
local StaminaRestoreSpeed 	= 0.75	
if (SERVER) then
	
	-- PlayerSpawn
	function StaminaStart( ply )
		timer.Destroy( "StaminaTimer" )
		ply:SetRunSpeed( DefaultRunSpeed )
		ply:SetNWInt( "Stamina", 100 )
		
		StaminaRestore( ply )
	end
	hook.Add( "PlayerSpawn", "StaminaStart", StaminaStart )
	
	-- KeyPress
	function StaminaPress( ply, key )
		if key == IN_SPEED or ply:KeyDown(IN_SPEED) then
			if ply:InVehicle() then return end
			if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
			if ply:GetMoveType() ==  MOVETYPE_LADDER then return end
			if ply:GetNWInt( "Stamina" ) >= DisableLevel then
				ply:SetRunSpeed( DefaultRunSpeed )
				timer.Destroy( "StaminaTimer" )
				timer.Create( "StaminaTimer", StaminaDrainSpeed, 0, function( )
					if ply:GetNWInt( "Stamina" ) <= 0 then
						ply:SetRunSpeed( DefaultWalkSpeed )
						timer.Destroy( "StaminaTimer" )
						return false
					end
					local vel = ply:GetVelocity()
					if vel.x >= DefaultWalkSpeed or vel.x <= -DefaultWalkSpeed or vel.y >= DefaultWalkSpeed or vel.y <= -DefaultWalkSpeed then
						ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
					end
				end)
			else
				ply:SetRunSpeed( DefaultWalkSpeed )
				timer.Destroy( "StaminaTimer" )
			end
		end
		if key == IN_JUMP or ply:KeyDown(IN_JUMP) then
			if ply:GetNWInt( "Stamina" ) >= DisableLevel then
				ply:SetJumpPower( DefaultJumpPower )
				ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
			else
				ply:SetJumpPower( 0 )
			end
		end
	end
	hook.Add( "KeyPress", "StaminaPress", StaminaPress ) 

	-- KeyRelease
	function StaminaRelease( ply, key )
		if key == IN_SPEED and !ply:KeyDown(IN_SPEED) then
			timer.Destroy( "StaminaTimer" )
			StaminaRestore( ply )
		end
	end
	hook.Add( "KeyRelease", "StaminaRelease", StaminaRelease ) 

	-- StaminaRestore
	function StaminaRestore( ply )
		timer.Create( "StaminaGain", StaminaRestoreSpeed, 0, function( ) 
			if ply:GetNWInt( "Stamina" ) >= 100 or (key == IN_SPEED and ply:KeyDown(IN_SPEED)) then
				return false
			else
				ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) + 1 )
			end
		end)
	end

end

function GM:PlayerSpawn(ply)
	ply:SetGravity(0.9)
	ply:SetMaxHealth(100)
	ply:SetRunSpeed(250)
	ply:SetWalkSpeed(150)
	ply:Give("weapon_physgun")
	if ply:IsAdmin() or ply:IsSuperAdmin() then ply:Give("gmod_tool") end
	ply:Give("weapon_fists")
	ply:Flashlight( false )
	ply:AllowFlashlight( true )
	ply:SetupHands()
	ply:SetNWInt("playerHunger", 100)
	ply:SetNWInt("playerThirst", 100)
	timer.Create( "Regen", 12, 0, function( )
	timer.Create( "im hurt", 12, 1, function( ) if ply:Health() < 40 then ply:ChatPrint("You are going to die soon!") elseif ply:Health() < 75 then ply:ChatPrint("You are hurt") end end)
		if ply:GetNWInt( "playerHunger" ) and ply:GetNWInt("playerThirst") >= 40 then
			ply:SetHealth(ply:Health() + 1)
			else return end
		end)
	timer.Create( "Thirst", 4, 0, function() ply:SetNWInt("playerThirst", ply:GetNWInt("playerThirst") - .5) 
	timer.Create( "im thirst", 12, 1, function( ) if ply:GetNWInt("playerThirst") < 40 then ply:ChatPrint("You need a drink now!") elseif ply:GetNWInt("playerThirst") < 75 then ply:ChatPrint("You are thirsty") end end)
	if ply:GetNWInt("playerThirst") <= 0 then  
	ply:SetNWInt("playerThirst", 100)
	ply:Kill()
		end
	end )
	timer.Create( "Hunger", 6, 0, function() ply:SetNWInt("playerHunger", ply:GetNWInt("playerHunger") - .5) 
	timer.Create( "Im hungry", 12, 1, function( ) if ply:GetNWInt("playerHunger") < 40 then ply:ChatPrint("You are starving!") elseif ply:GetNWInt("playerHunger") < 75 then ply:ChatPrint("You are hungry") end end)
	if ply:GetNWInt("playerHunger") <= 0 then  
	ply:SetNWInt("playerHunger", 100)
	ply:Kill()
	sound.Play( "player/pl_pain5.wav", ply:GetPos() )
		end
	end )
end

function GM:OnNPCKilled(npc, attacker, inflictor)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 200)
	
	attacker:SetNWInt("playerXP", attacker:GetNWInt("playerXP") + 200) 
	
	checkForLevel(attacker)
	
	attacker:SetNWInt("playerMaterials", attacker:GetNWInt("playerMaterials") + math.random(5,1))
	
	attacker:SetNWInt("playerMetal", attacker:GetNWInt("playerMetal") + math.random(1,5))
	
	attacker:SetNWInt("playerPlastic", attacker:GetNWInt("playerPlastic") + math.random(0,1))
	
	TimerCheck(attacker)
	
	
end

function TimerCheck(ply)
	timer.Destroy("Thirst")
	timer.Create( "Thirst", 4, 0, function() ply:SetNWInt("playerThirst", ply:GetNWInt("playerThirst") - .5) 
	if ply:GetNWInt("playerThirst") <= 0 then  
	ply:SetNWInt("playerThirst", 100)
	ply:Kill()
		end
	end )
	timer.Destroy("Hunger")
	timer.Create( "Hunger", 6, 0, function() ply:SetNWInt("playerHunger", ply:GetNWInt("playerHunger") - .5) 
	if ply:GetNWInt("playerHunger") <= 0 then  
	ply:SetNWInt("playerHunger", 100)
	ply:Kill()
	sound.Play( "player/pl_pain5.wav", ply:GetPos() )
		end
	end )

end

function GM:PlayerDeath(victim, inflictor, attacker)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 200)
	
	attacker:SetNWInt("playerXP", attacker:GetNWInt("playerXP") + 350) 
	
	checkForLevel(attacker)
	
	if(attacker == victim) then return end
	attacker:SetFrags(attacker:Frags() + 1)
	
	TimerCheck(attacker)
	
	attacker:ChatPrint("You have earned 350XP and $200!")
end

function GM:PlayerCanHearPlayersVoice( listener, talker )
	return ( listener:GetPos():Distance( talker:GetPos() ) <= 500 )
end

function Survey(ply)
	ply:SetFOV(15,1)
end
concommand.Add("survey_area", Survey)


function GM:PlayerGiveSWEP( ply, class, swep )
	if (ply:IsAdmin() or ply:IsSuperAdmin()) then
		return true
	else
		return false
	end
end

	
function checkForLevel(ply)
	local xpToLvl = (ply:GetNWInt("playerLvl")* 100) * 3
	local curXp = ply:GetNWInt("playerXp")
	local curLvl = ply:GetNWInt("playerLvl")
	
	if (curXp >= xpToLvl) then
		curXp = curXp - xpToLvl
		
		ply:SetNWInt("playerXp", curXp)
		ply:SetNWInt("playerLvl", curLvl + 1)
		ply:SetNWInt("playerMoney", ply:GetNWInt("playerMoney") + 1200)
		ply:SetNWInt("playerLvlPoint", ply:GetNWInt("playerLvlPoint") + 1)
	end
end

function GM:ShowHelp(ply)
	ply:ConCommand("inventory")
end

function ResetLvls(ply)
	ply:SetNWInt("playerLvl", 1)
	ply:SetNWInt("playerXp", 0)
end
concommand.Add("resetlvl", ResetLvls)

function resetcash(ply)
	ply:SetNWInt("playerMoney", 0)
end
concommand.Add("resetcashfordebugreasons", resetcash)

net.Receive("KEY_T", function(len, ply)
	hook.Call("KEY_T", GAMEMODE, ply)
end)

local ShouldDropWeapon = true
 
local function ToggleDropWeapon(ply)
	if ply:IsAdmin() then
		if ShouldDropWeapon then --Because ShouldDropWeapon is a bool, it'll be a true or false.
                        --If true then
			ply:PrintMessage(HUD_PRINTNOTIFY, "Weapon drop disabled") --Tell us if it is enabled.
			ShouldDropWeapon = false
		else --Else do
			ply:PrintMessage(HUD_PRINTNOTIFY, "Weapon drop enabled")
			ShouldDropWeapon = true
		end
	end
end
concommand.Add( "player_dropweapon_toggle", ToggleDropWeapon)  --Toggle usage of PlayerDropWeapon
 
local function PlayerDropWeapon(ply)
	if ShouldDropWeapon and ply:GetActiveWeapon():IsValid() then --If weapon dropping is enabled, and player's weapon is valid.
		ply:DropWeapon(ply:GetActiveWeapon()) --Drop active weapon
	end
end
hook.Add("DoPlayerDeath", "Player.DropWeapon", PlayerDropWeapon)
concommand.Add( "player_dropweapon", PlayerDropWeapon) --Make user drop his weapon.