ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Blue NPC"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( anim )

	self.AutomaticFrameAdvance = anim
	
end 

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "Emotion") --4 - 0
	self:NetworkVar( "Bool", 0, "IsDying")
	self:NetworkVar("Entity" , 0 , "Glass")
	self:NetworkVar("String" , 0 , "WantedDrink")

end
