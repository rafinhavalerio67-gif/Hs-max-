--==================================================
-- FFH4X | AIMBOT + ESP | COMPACTO
-- Roblox Studio - LocalScript
--==================================================

local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local L=P.LocalPlayer
local G=L:WaitForChild("PlayerGui")
local C=workspace.CurrentCamera

-- CONFIG
local X={
	Injected=false,Aimbot=false,Target="Cabeça",AutoFire=false,
	ESPLine=false,ESPBox=false,ESPSkeleton=false,ESPHealth=false,
	FOV=120,ShowFOV=false,MaxDistance=1500
}

-- LIMPEZA
for _,n in ipairs({"FFH4X","FFH4X_ESP"}) do
	local o=G:FindFirstChild(n)
	if o then o:Destroy() end
end

-- GUI
local GUI=Instance.new("ScreenGui",G)
GUI.Name="FFH4X"
GUI.ResetOnSpawn=false
GUI.IgnoreGuiInset=true
GUI.DisplayOrder=100

local M=Instance.new("Frame",GUI)
M.Size=UDim2.fromOffset(420,380)
M.Position=UDim2.new(0,25,.5,-190)
M.BackgroundColor3=Color3.fromRGB(15,15,18)
M.BorderSizePixel=0
Instance.new("UICorner",M).CornerRadius=UDim.new(0,8)

local function stroke(o,c,t)
	local s=Instance.new("UIStroke",o)
	s.Color=c;s.Thickness=t or 1
end
stroke(M,Color3.fromRGB(65,65,72))

-- HEADER
local H=Instance.new("Frame",M)
H.Size=UDim2.new(1,0,0,50)
H.BackgroundColor3=Color3.fromRGB(25,25,29)
H.BorderSizePixel=0

local title=Instance.new("TextLabel",H)
title.Position=UDim2.fromOffset(15,4)
title.Size=UDim2.new(1,-100,0,25)
title.BackgroundTransparency=1
title.Text="FFH4X"
title.Font=Enum.Font.GothamBold
title.TextSize=19
title.TextColor3=Color3.fromRGB(245,245,245)
title.TextXAlignment=Enum.TextXAlignment.Left

local sub=Instance.new("TextLabel",H)
sub.Position=UDim2.fromOffset(16,27)
sub.Size=UDim2.new(1,-100,0,14)
sub.BackgroundTransparency=1
sub.Text="AIMBOT / ESP"
sub.Font=Enum.Font.Gotham
sub.TextSize=8
sub.TextColor3=Color3.fromRGB(125,125,133)
sub.TextXAlignment=Enum.TextXAlignment.Left

local function HB(txt,x)
	local b=Instance.new("TextButton",H)
	b.Size=UDim2.fromOffset(28,28)
	b.Position=UDim2.new(1,x,0,11)
	b.BackgroundColor3=Color3.fromRGB(35,35,40)
	b.Text=txt
	b.TextColor3=Color3.fromRGB(230,230,235)
	b.Font=Enum.Font.GothamBold
	b.TextSize=16
	b.BorderSizePixel=0
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)
	return b
end

local Min=HB("—",-66)
local Close=HB("×",-34)

-- CONTEÚDO
local Q=Instance.new("Frame",M)
Q.Position=UDim2.fromOffset(12,58)
Q.Size=UDim2.new(1,-24,1,-66)
Q.BackgroundTransparency=1

local function button(txt,x,y,w,h)
	local b=Instance.new("TextButton",Q)
	b.Position=UDim2.fromOffset(x,y)
	b.Size=UDim2.fromOffset(w or 190,h or 30)
	b.BackgroundColor3=Color3.fromRGB(31,31,36)
	b.Text=txt
	b.TextColor3=Color3.fromRGB(205,205,210)
	b.Font=Enum.Font.GothamMedium
	b.TextSize=10
	b.BorderSizePixel=0
	b.AutoButtonColor=false
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
	stroke(b,Color3.fromRGB(54,54,61))
	return b
end

local function state(b,on)
	b.BackgroundColor3=on and Color3.fromRGB(100,28,28)
		or Color3.fromRGB(31,31,36)
	b.TextColor3=on and Color3.new(1,1,1)
		or Color3.fromRGB(195,195,200)
end

-- INJETAR
local Inject=button("INJETAR",0,0,396,32)

Inject.MouseButton1Click:Connect(function()
	X.Injected=true
	Inject.Text="INJETADO ✓"
	state(Inject,true)
	task.delay(1,function()
		if Inject.Parent then
			Inject.Text="INJETAR"
			state(Inject,false)
		end
	end)
end)

-- AIMBOT
local Aim=button("AIMBOT OFF",0,40,190,30)
Aim.MouseButton1Click:Connect(function()
	X.Aimbot=not X.Aimbot
	Aim.Text="AIMBOT "..(X.Aimbot and "ON" or "OFF")
	state(Aim,X.Aimbot)
end)

-- ALVO
local TB=button("ALVO: "..X.Target,198,40,198,30)
local Menu=Instance.new("Frame",Q)
Menu.Position=UDim2.fromOffset(198,72)
Menu.Size=UDim2.fromOffset(198,96)
Menu.BackgroundColor3=Color3.fromRGB(23,23,27)
Menu.BorderSizePixel=0
Menu.Visible=false
Menu.ZIndex=30
Instance.new("UICorner",Menu).CornerRadius=UDim.new(0,6)
stroke(Menu,Color3.fromRGB(65,65,72))

for i,n in ipairs({"Cabeça","Pescoço","Peito"}) do
	local b=Instance.new("TextButton",Menu)
	b.Position=UDim2.fromOffset(4,(i-1)*31+3)
	b.Size=UDim2.new(1,-8,0,27)
	b.BackgroundColor3=Color3.fromRGB(32,32,37)
	b.Text=n
	b.TextColor3=Color3.fromRGB(220,220,225)
	b.Font=Enum.Font.GothamMedium
	b.TextSize=10
	b.BorderSizePixel=0
	b.ZIndex=31
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)
	b.MouseButton1Click:Connect(function()
		X.Target=n
		TB.Text="ALVO: "..n
		Menu.Visible=false
	end)
end

TB.MouseButton1Click:Connect(function()
	Menu.Visible=not Menu.Visible
end)

-- TOGGLES
local function toggle(txt,key,x,y)
	local b=button(txt.." OFF",x,y,190,30)
	b.MouseButton1Click:Connect(function()
		X[key]=not X[key]
		b.Text=txt.." "..(X[key] and "ON" or "OFF")
		state(b,X[key])
	end)
end

local Auto=button("DISPARO AUTO OFF",198,78,198,30)
Auto.MouseButton1Click:Connect(function()
	X.AutoFire=not X.AutoFire
	Auto.Text="DISPARO AUTO "..(X.AutoFire and "ON" or "OFF")
	state(Auto,X.AutoFire)
end)

toggle("ESP LINHA","ESPLine",0,116)
toggle("ESP BOX","ESPBox",198,116)
toggle("ESP ESQUELETO","ESPSkeleton",0,150)
toggle("ESP VIDA","ESPHealth",198,150)
toggle("VER FOV","ShowFOV",0,184)

-- FOV
local FF=Instance.new("Frame",Q)
FF.Position=UDim2.fromOffset(0,218)
FF.Size=UDim2.fromOffset(396,42)
FF.BackgroundColor3=Color3.fromRGB(31,31,36)
FF.BorderSizePixel=0
Instance.new("UICorner",FF).CornerRadius=UDim.new(0,6)
stroke(FF,Color3.fromRGB(54,54,61))

local FT=Instance.new("TextLabel",FF)
FT.Position=UDim2.fromOffset(10,0)
FT.Size=UDim2.fromOffset(35,42)
FT.BackgroundTransparency=1
FT.Text="FOV"
FT.Font=Enum.Font.GothamBold
FT.TextSize=10
FT.TextColor3=Color3.fromRGB(225,225,230)

local FV=FT:Clone()
FV.Parent=FF
FV.Position=UDim2.fromOffset(45,0)
FV.Size=UDim2.fromOffset(42,42)
FV.Text=tostring(X.FOV)

local Bar=Instance.new("Frame",FF)
Bar.Position=UDim2.fromOffset(92,19)
Bar.Size=UDim2.fromOffset(290,5)
Bar.BackgroundColor3=Color3.fromRGB(58,58,64)
Bar.BorderSizePixel=0

local Fill=Instance.new("Frame",Bar)
Fill.BackgroundColor3=Color3.fromRGB(175,35,35)
Fill.BorderSizePixel=0

local Knob=Instance.new("Frame",Bar)
Knob.Size=UDim2.fromOffset(12,12)
Knob.AnchorPoint=Vector2.new(.5,.5)
Knob.BackgroundColor3=Color3.fromRGB(235,235,235)
Knob.BorderSizePixel=0
Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0)

local function setFov(x)
	local p=math.clamp((x-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
	X.FOV=math.floor(30+p*370)
	Fill.Size=UDim2.new(p,0,1,0)
	Knob.Position=UDim2.new(p,0,.5,0)
	FV.Text=tostring(X.FOV)
end

local slide=false
Bar.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or
		i.UserInputType==Enum.UserInputType.Touch then
		slide=true
		setFov(i.Position.X)
	end
end)

U.InputChanged:Connect(function(i)
	if slide and (i.UserInputType==Enum.UserInputType.MouseMovement or
		i.UserInputType==Enum.UserInputType.Touch) then
		setFov(i.Position.X)
	end
end)

U.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 or
		i.UserInputType==Enum.UserInputType.Touch then
		slide=false
	end
end)

-- FOV VISUAL
local FOV=Instance.new("Frame",GUI)
FOV.AnchorPoint=Vector2.new(.5,.5)
FOV.Position=UDim2.fromScale(.5,.5)
FOV.Size=UDim2.fromOffset(X.FOV*2,X.FOV*2)
FOV.BackgroundTransparency=1
Instance.new("UICorner",FOV).CornerRadius=UDim.new(1,0)
local FS=Instance.new("UIStroke",FOV)
FS.Color=Color3.fromRGB(190,35,35)

-- ALVO
local function aimPart(c)
	local h=c:FindFirstChild("Head")
	local u=c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso")
	if X.Target=="Cabeça" then return h end
	if X.Target=="Peito" then return u or h end
	if h and u then return {Position=u.Position:Lerp(h.Position,.72)} end
	return h
end

local function visible(p,c)
	local rp=RaycastParams.new()
	rp.FilterType=Enum.RaycastFilterType.Exclude
	rp.FilterDescendantsInstances={L.Character,c}
	return not workspace:Raycast(C.CFrame.Position,p.Position-C.CFrame.Position,rp)
end

local function closest()
	local center=Vector2.new(C.ViewportSize.X/2,C.ViewportSize.Y/2)
	local best,dist
	dist=X.FOV

	for _,pl in ipairs(P:GetPlayers()) do
		if pl~=L then
			local c=pl.Character
			local h=c and c:FindFirstChildOfClass("Humanoid")
			local r=c and c:FindFirstChild("HumanoidRootPart")
			local p=c and aimPart(c)

			if h and h.Health>0 and r and p and
				(C.CFrame.Position-p.Position).Magnitude<=X.MaxDistance then

				local s,on=C:WorldToViewportPoint(p.Position)
				if on then
					local d=(Vector2.new(s.X,s.Y)-center).Magnitude
					if d<=dist and visible(p,c) then
						dist=d
						best=p
					end
				end
			end
		end
	end
	return best
end

-- ESP
local EG=Instance.new("ScreenGui",G)
EG.Name="FFH4X_ESP"
EG.ResetOnSpawn=false
EG.IgnoreGuiInset=true
EG.DisplayOrder=50

local E={}

local function add(pl)
	if pl==L then return end

	local f=Instance.new("Folder",EG)
	local b=Instance.new("Frame",f)
	b.BackgroundTransparency=1
	b.Visible=false
	stroke(b,Color3.fromRGB(210,35,35))

	local line=Instance.new("Frame",f)
	line.AnchorPoint=Vector2.new(.5,.5)
	line.BackgroundColor3=Color3.fromRGB(210,35,35)
	line.BorderSizePixel=0
	line.Visible=false

	local hb=Instance.new("Frame",f)
	hb.BackgroundColor3=Color3.fromRGB(20,20,20)
	hb.BorderSizePixel=0
	hb.Visible=false

	local hp=Instance.new("Frame",hb)
	hp.BackgroundColor3=Color3.fromRGB(40,220,60)
	hp.BorderSizePixel=0
	hp.AnchorPoint=Vector2.new(0,1)
	hp.Position=UDim2.new(0,0,1,0)
	hp.Size=UDim2.new(1,0,1,0)

	local s={}
	local bones={
		{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
		{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},
		{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},
		{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
		{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},
		{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},
		{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}
	}

	for i,v in ipairs(bones) do
		local o=Instance.new("Frame",f)
		o.AnchorPoint=Vector2.new(.5,.5)
		o.Size=UDim2.fromOffset(2,2)
		o.BackgroundColor3=Color3.fromRGB(210,35,35)
		o.BorderSizePixel=0
		o.Visible=false
		s[i]={o,v[1],v[2]}
	end

	E[pl]={F=f,B=b,L=line,H=hb,HP=hp,S=s}
end

local function remove(pl)
	if E[pl] then E[pl].F:Destroy();E[pl]=nil end
end

for _,p in ipairs(P:GetPlayers()) do add(p) end
P.PlayerAdded:Connect(add)
P.PlayerRemoving:Connect(remove)

local function lineBetween(o,a,b)
	local d=b-a
	o.Position=UDim2.fromOffset((a.X+b.X)/2,(a.Y+b.Y)/2)
	o.Size=UDim2.fromOffset(2,d.Magnitude)
	o.Rotation=math.deg(math.atan2(d.Y,d.X))+90
end

local function autoFire()
	local c=L.Character
	local t=c and c:FindFirstChildOfClass("Tool")
	if X.AutoFire and t then pcall(function() t:Activate() end) end
end

-- RENDER
R.RenderStepped:Connect(function()
	FOV.Visible=X.Injected and X.ShowFOV
	FOV.Size=UDim2.fromOffset(X.FOV*2,X.FOV*2)

	if X.Injected and X.Aimbot then
		local p=closest()
		if p then
			C.CFrame=CFrame.lookAt(C.CFrame.Position,p.Position)
			if X.AutoFire then autoFire() end
		end
	end

	for pl,d in pairs(E) do
		local c=pl.Character
		local h=c and c:FindFirstChildOfClass("Humanoid")
		local r=c and c:FindFirstChild("HumanoidRootPart")

		d.B.Visible=false
		d.L.Visible=false
		d.H.Visible=false
		for _,s in ipairs(d.S) do s[1].Visible=false end

		if X.Injected and h and h.Health>0 and r then
			local cf,size=c:GetBoundingBox()
			local pts={}

			for _,v in ipairs({
				Vector3.new(-size.X/2,-size.Y/2,-size.Z/2),
				Vector3.new(size.X/2,-size.Y/2,-size.Z/2),
				Vector3.new(-size.X/2,size.Y/2,-size.Z/2),
				Vector3.new(size.X/2,size.Y/2,-size.Z/2),
				Vector3.new(-size.X/2,-size.Y/2,size.Z/2),
				Vector3.new(size.X/2,-size.Y/2,size.Z/2),
				Vector3.new(-size.X/2,size.Y/2,size.Z/2),
				Vector3.new(size.X/2,size.Y/2,size.Z/2)
			}) do
				local p,on=C:WorldToViewportPoint(cf:PointToWorldSpace(v))
				if on and p.Z>0 then
					pts[#pts+1]=Vector2.new(p.X,p.Y)
				end
			end

			if #pts>0 then
				local minx,maxx,miny,maxy=pts[1].X,pts[1].X,pts[1].Y,pts[1].Y
				for _,p in ipairs(pts) do
					minx=math.min(minx,p.X);maxx=math.max(maxx,p.X)
					miny=math.min(miny,p.Y);maxy=math.max(maxy,p.Y)
				end

				local w=math.max(maxx-minx,18)
				local ht=math.max(maxy-miny,38)
				local cx=(minx+maxx)/2
				minx=cx-w/2
				local cy=(miny+maxy)/2
				miny=cy-ht/2

				if X.ESPBox then
					d.B.Visible=true
					d.B.Position=UDim2.fromOffset(minx,miny)
					d.B.Size=UDim2.fromOffset(w,ht)
				end

				if X.ESPHealth then
					local hp=math.clamp(h.Health/h.MaxHealth,0,1)
					d.H.Visible=true
					d.H.Position=UDim2.fromOffset(minx-7,miny)
					d.H.Size=UDim2.fromOffset(4,ht)
					d.HP.Size=UDim2.new(1,0,hp,0)
				end

				if X.ESPLine then
					d.L.Visible=true
					lineBetween(d.L,
						Vector2.new(C.ViewportSize.X/2,0),
						Vector2.new(cx,miny))
				end
			end

			if X.ESPSkeleton then
				for _,s in ipairs(d.S) do
					local a=c:FindFirstChild(s[2])
					local b=c:FindFirstChild(s[3])
					if a and b then
						local p1,o1=C:WorldToViewportPoint(a.Position)
						local p2,o2=C:WorldToViewportPoint(b.Position)
						if o1 and o2 and p1.Z>0 and p2.Z>0 then
							lineBetween(s[1],
								Vector2.new(p1.X,p1.Y),
								Vector2.new(p2.X,p2.Y))
							s[1].Visible=true
						end
					end
				end
			end
		end
	end
end)

-- MINIMIZAR / FECHAR
local minimized=false
Min.MouseButton1Click:Connect(function()
	minimized=not minimized
	Q.Visible=not minimized
	M.Size=minimized and UDim2.fromOffset(420,50) or UDim2.fromOffset(420,380)
	Min.Text=minimized and "+" or "—"
end)

Close.MouseButton1Click:Connect(function()
	GUI:Destroy()
	EG:Destroy()
end)
