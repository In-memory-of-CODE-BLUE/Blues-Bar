ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Message"
ENT.Spawnable = true 
ENT.Category = "BLUES BAR"

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "MessageType") 
	self:NetworkVar( "String", 1, "MessageText")

end