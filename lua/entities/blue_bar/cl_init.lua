include("shared.lua")


surface.CreateFont( "BB_Title", {
	font = "Nexa Light", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 100,
	weight = 1000,
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
surface.CreateFont( "BB_SubTitle", {
	font = "Nexa Light", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 45,
	weight = 1000,
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
 
function ENT:Draw()
		self:DrawModel()	 
		if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then
			if not self:GetInUse() then 
				local ang = Angle(0, 0 ,90)
				ang:RotateAroundAxis(Vector(0,0,1),LocalPlayer():GetAngles().y - 90)
				--ang:RotateAroundAxis(self:GetAngles():Forward(),90)
				--ang:RotateAroundAxis(self:GetAngles():Right(),180)
				cam.Start3D2D(self:GetPos() + Vector(0,0,75) , ang, 0.12)
					draw.SimpleText("BLUES BAR" , "BB_Title",0 , 20,Color(188,0,251,255),1,0)
								draw.SimpleText("PRESS 'E' TO WORK" , "BB_SubTitle",0 , 100,Color(188,0,251,255),1,0)
				cam.End3D2D()  
			end 
		end
end