--config
local notifytext="[ANTIOBKAK] %s %s: %s"
local admins={
["admin"]=true,
["superadmin"]=true
}
local notifydelay = 50
local activefunctions={
	--detect on 2 jump while holding the spacebar
	bhopchecker=true,
	--check silent and nospread with client and server angle
	aimchecker=true,
	--check obkak antisg methods
	antisgchecker=true,
	--obkak many cheats,remove ur shitten optimization to use it
	espbreaker=true,
	--nospread breaker for m9k/hl2/tfa, pasted from another anti-cheat
	nospreadbreaker=true
}
--code
if SERVER then
	--report
	local timerx={}
	local function sendreport(p,r)
		if timerx.p and timerx.p>CurTime()then return end	
		for _,v in next,player.GetAll()do
			if admins[v:GetUserGroup()]then
				v:ChatPrint(string.format(notifytext,p:Name(),p:SteamID(),r))
			end
		end
		timerx.p=CurTime()+notifydelay
	end
	util.AddNetworkString("krinjanium")
	net.Receive("krinjanium",function(_,p)
		local n=net.ReadFloat()
		if n==1 then sendreport(p,"detected bunnyhop(95% chance)")end
		if n==2 then sendreport(p,"detected anti screengrab protect(100% cheater)")end
	end)
	--aim checker
	util.AddNetworkString("cringe")
	net.Receive("cringe",function(_,p)
		local rl,fk=net.ReadAngle(),p:EyeAngles()
		local x,y=tonumber(tostring(math.Round(math.AngleDifference(rl.x,fk.x))):Replace("-","")),tonumber(tostring(math.Round(math.AngleDifference(rl.y,fk.y))):Replace("-",""))
		if x>1 and y>1 then
			sendreport(p,"detected silent aim(the more the more likely X:"..x.." Y:"..y..")")
		end
	end)
	local c=FindMetaTable"Entity"
	if activefunctions.nospreadbreaker then
		c.OldFireBullets = c.OldFireBullets or c.FireBullets
		local function f()return math.random()*5-1 end
		function c:FireBullets(g,h)
			local i=g.Spread
			if type(i)=="Vector"then
				g.Spread=vector_origin
				math.randomseed(CurTime()+math.sqrt(g.Dir.x^2*g.Dir.y^2*g.Dir.z^2))
				g.Dir=g.Dir+Vector(i.x*f(),i.y*f(),i.z*f())
			end
			self:OldFireBullets(g,h)
		end
	end
	return
end
--send report
local timerx
local function report(n)
	if timerx and timerx>CurTime()then return end	
	net.Start("krinjanium")
	net.WriteFloat(n)
	net.SendToServer()
	timerx=CurTime()+notifydelay
end
--aim checker
gameevent.Listen("entity_killed")
hook.Add("entity_killed","entity_killed_example",function(d) 
	if activefunctions.aimchecker and d.entindex_attacker==LocalPlayer():EntIndex()then
		net.Start("cringe")
		net.WriteAngle(render.GetViewSetup().angles)
		net.SendToServer()
	end
end)
--bhop checker
local s=false
local P=0
local R=0
hook.Add("Think","obkak",function()
	if not activefunctions.bhopchecker then return end
	if not s then s=LocalPlayer()return end
	if gui.IsGameUIVisible()or gui.IsConsoleVisible()or s:IsTyping()or not s:GetMoveType()==2 then return end
	if input.IsKeyDown(65)then
		P=P+1
	else
		P=0
	end
	if not s:OnGround()then
		R=R+1
	else
		R=0
	end
	if P>100 and R<30 and R>1 then
		report(1)
	end
end)
--antisg checker
local a=false
local b=false
local c=false
local d=false
local e=false
local f=false
hook.Add("PreRender","obkak",function()
	e=true
	d=false
	render.SetRenderTarget()
end)
local g=GetRenderTarget("obkak"..ScrW().."_"..ScrH(),ScrW(),ScrH())
hook.Add("PostRender","obkak",function(h,i,j)
	if d then return end
	e=false
	if f then
		render.PushRenderTarget(g)
	else
		render.CopyRenderTargetToTexture(g)
		render.SetRenderTarget(g)
	end
	if b or f then
		b=false
		if jit.version=="LuaJIT 2.1.0-beta3"then
			if f then
				f=false
			else
				f=true
				return
			end
		end
		cam.Start2D()
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(0,0,1,1)
		cam.End2D()
		render.CapturePixels()
		local k,l,m=render.ReadPixel(0,0)
		if k~=255 or l~=255 or m~=255 then
			report(2)
			return
		end
		a=true
		local n=FrameNumber()
		local o=render.Capture({format="jpeg",quality=1,x=0,y=0,w=ScrW(),h=ScrH()})
		local p=FrameNumber()
		a=false
		if n~=p then
			report(2)
			return
		end
	end
	if f then
		render.PopRenderTarget()
		render.CopyRenderTargetToTexture(g)
		render.SetRenderTarget(g)
	end
end)
hook.Add("PreDrawViewModel","obkak",function()
	if a then
		report(2)
		c=true
	end
end)
hook.Add("ShutDown","obkak",function()
	d=true
	render.SetRenderTarget()
end)
hook.Add("DrawOverlay","obkak",function()
	if not e then
		d=true
		render.SetRenderTarget()
	end
end)
timer.Simple(5,function()
	b=activefunctions.antisgchecker
end)
--esp breaker
timer.Create("obkak",2,0,function()
	if not activefunctions.espbreaker then return end
    for _,p in next,player.GetAll()do
        if p:GetPos():Distance(LocalPlayer():GetPos())>1 and p:GetPos():Distance(LocalPlayer():GetPos())<5000 then
            p:SetCollisionBounds(Vector(0,-1000,-1000),Vector(0,-1000,-1000))
        end
    end
end)
