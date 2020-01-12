include("shared.lua")

function ENT:Draw()

	if self.ang == nil then self.ang = 0 end
	if self.scale == nil then self.scale = 0 end
	if self.fakeColor == nil then self.fakeColor = Color(180,180,180) end
	
	self:DrawModel()--We dont draw becuase of a rendering issue so it gets called after the customer is rendered.

	self.scale = Lerp(0.6*FrameTime() , self.scale , math.Clamp(self:GetLiquidAmount(0) , 0 , 7))

	self:SetModelScale(self.scale * 0.75,0)

	local ings = util.JSONToTable(self:GetGlassIngs())

	local colors = {}

	if #ings > 0 then
		
		for k , v in pairs(ings) do

			for a = 1 , bb_bottles.colors[v].density do

				table.insert(colors , bb_bottles.colors[v].color)

			end

		end

		self.fakeColor = lerpColor(0.6*FrameTime() , self.fakeColor , mixColors(colors))

	end

	self:SetColor(self.fakeColor)

end

function lerpColor(t , c1 , c2)

	local r = Lerp(t , c1.r , c2.r)
	local g = Lerp(t , c1.g , c2.g)
	local b = Lerp(t , c1.b , c2.b)

	return Color(r , g , b)

end

function mixColors(colors)

	local newCol = Color(0,0,0)

	local r = 0
	local g = 0
	local b = 0

	for i = 1 , #colors do
		
		r = r + colors[i].r
		g = g + colors[i].g
		b = b + colors[i].b

	end

	local count = table.Count(colors)

	newCol = Color(r / count, g / count , b / count , 255)

	return newCol

end

