ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Liquid"
ENT.Spawnable = true
ENT.Category = "BLUES BAR"

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "LiquidAmount")
	self:NetworkVar( "String", 1, "GlassIngs")

end