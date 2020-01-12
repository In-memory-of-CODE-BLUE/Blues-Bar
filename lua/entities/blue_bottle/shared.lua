ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Bottle"
ENT.Spawnable = true
ENT.Category = "BLUES BAR"

function ENT:SetupDataTables()

	self:NetworkVar( "String", 0, "BottleName")
	self:NetworkVar( "Entity", 3, "ConnectedBar" )
	self:NetworkVar( "Bool" , 4 , "IsBusy")

end 
