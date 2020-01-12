ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Glass"
ENT.Spawnable = true
ENT.Category = "BLUES BAR"

function ENT:SetupDataTables()

	self:NetworkVar( "String", 0, "BottleName")
	self:NetworkVar("String" , 3 , "Ingredients")
	self:NetworkVar("Entity",4, "Customer")
	self:NetworkVar( "Bool" , 5 , "IsBusy")

end
