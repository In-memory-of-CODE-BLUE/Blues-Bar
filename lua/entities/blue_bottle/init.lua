AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

local bottleTypes = {
	[1] = "models/blues-bar/bottle_1.mdl",
	[2] = "models/blues-bar/bottle_2.mdl",
	[3] = "models/blues-bar/bottle_3.mdl"
}

function ENT:Initialize()

	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )       
	self:SetUseType(SIMPLE_USE)   
 	self.isRunning = false
 	self:SetCollisionGroup(COLLISION_GROUP_WEAPON) 
  local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetIsBusy(false) 

end


function ENT:SetBottleInfo(name , bt , materialBottle, materialGlass, desc , ent)

	self:SetModel(bottleTypes[bt])
	self:SetSubMaterial(0,materialBottle)
	self:SetSubMaterial(1,materialGlass)
	self:SetBottleName(name)
	self:SetConnectedBar(ent)

end

function ENT:PourAnimation(glass , amount)

	self.glass = glass
	self.origin = self:GetPos()
	self.originang = self:GetAngles()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right() , 90)
	self:SetAngles(ang)
	self:SetPos(glass:GetPos() + (glass:GetAngles():Up() * 35))
	timer.Simple(1 * amount, function()

		self:SetIsBusy(false)
		self:SetPos(self.origin)
		if IsValid(self.glass) then
			self.glass:SetIsBusy(false)
		end
		self:SetAngles(self.originang)

	end)


end
