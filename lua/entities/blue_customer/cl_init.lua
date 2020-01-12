include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

surface.CreateFont( "CivDrinkFont", {
	font = "Nexa Light", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 75,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local civBackground = Material("blues-bar/civbackdrop.png","noclamp smooth")
local faces = {
	Material("blues-bar/angry.png","noclamp smooth"),
	Material("blues-bar/neutral.png","noclamp smooth"),
	Material("blues-bar/happy.png","noclamp smooth"),
	Material("blues-bar/veryhappy.png","noclamp smooth"),

}

function ENT:Draw()

self:DrawModel() 

	if self.scaleTime == nil then
		self.scaleTime = 0
		self.scale = self:GetModelScale()
		self.alpha = 0
		self.face = math.random(1,4)
	end

	if self:GetIsDying() then 

		self.scaleTime = self.scaleTime - FrameTime()
		self.alpha = self.scaleTime * 255
		self:SetModelScale(berp(self.scaleTime,0 , self.scale))

	else 

		if self.scaleTime < 1 then
		
			self:SetModelScale(berp(self.scaleTime,0 , self.scale))

			self.scaleTime = self.scaleTime + (FrameTime() / 1)
			self.alpha = self.scaleTime * 255

		end

	end

	
	if self:GetIsDying() ~= true  then
		self:GetGlass():DrawModel()
	end


	--Draw Cam2D3D HERE

	local ang = Angle(-90,0,0) + Angle(90 , self:GetAngles().y - 270, 90)
 
	cam.Start3D2D(self:GetPos() + Vector(0,0,100) , ang, 0.045)

		surface.SetMaterial(civBackground)
		surface.SetDrawColor(255,255,255,self.alpha)
		surface.DrawTexturedRect(-256 , 0 , 1024/2 , 1124/2)

		draw.SimpleText(self:GetWantedDrink() , "CivDrinkFont",0 , 20,Color(30,30,30 , self.alpha),1,0)

		surface.SetMaterial(faces[self:GetEmotion()])
		surface.SetDrawColor(255,255,255,self.alpha)
		surface.DrawTexturedRect(-350 / 2 , 100 , 350,350)

	cam.End3D2D()

end

function berp(v ,s, e)

	v = math.Clamp(v , 0 ,1)
	v = (math.sin(v * math.pi * (0.2 + 2.5 * v * v * v)) * math.pow(1 - v, 2.2) + v) * (1 + (1.2 * (1 - v)))

	return v

end

function ENT:SetRagdollBones( b )

	self.m_bRagdollSetup = b

end

function ENT:DrawTranslucent()

	self:Draw()

end


