function GM:RenderScreenspaceEffects()
	if LocalPlayer():Health() <= 35 then
	DrawMotionBlur( 0.4, 0.8, 0.01 )
	end
end

local function keyT()
	if input.IsKeyDown(KEY_T) then
		net.Start("KEY_T")
		net.SendToServer()
		
		hook.Call("KEY_T", GAMEMODE, ply)
	end
end
hook.Add( "Think", "t_pressed", keyT )
