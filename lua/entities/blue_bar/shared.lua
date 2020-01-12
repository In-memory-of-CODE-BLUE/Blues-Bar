ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Bar"
ENT.Spawnable = true
ENT.Category = "BLUES BAR"


function ENT:SetupDataTables()

	self:NetworkVar( "Bool" , 0 , "InUse") 

end