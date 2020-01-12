include("shared.lua")

surface.CreateFont( "BlueMessageFont", {
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

function ENT:Draw()   
	if self.time == nil then self.time = 0 end
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 700 then
		local ang = Angle(-90,0,0) + Angle(90 , self:GetAngles().y - 270, 90)
		cam.Start3D2D(self:GetPos() , ang, 0.1)
				if self:GetMessageType() == 1 then 
					draw.SimpleText(self:GetMessageText(), "BlueMessageFont",0 , Lerp(self.time/3.0 , 0,500) * -1,Color(100,230,100,Lerp(self.time/3.0 , 255 , 0)),1,0)
				elseif self:GetMessageType() == 2 then   
					draw.SimpleText(self:GetMessageText(), "BlueMessageFont",0 , Lerp(self.time/3.0 , 0,500) * -1,Color(230,80,80,Lerp(self.time/3.0 , 255 , 0)),1,0)	
				end
		cam.End3D2D()   
	end
	self.time = self.time + FrameTime() 
end
 
 
