AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()
 
	self:SetModel("models/blues-bar/glass.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )       
	self:SetUseType(SIMPLE_USE)  
 	self.isRunning = false
 	self:SetCollisionGroup(COLLISION_GROUP_WEAPON) 
 	local t = {}
 	self:SetIngredients(util.TableToJSON(t))
  local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	local liquid = ents.Create("blue_liquid")
	liquid:SetPos(self:GetPos() + (self:GetAngles():Up() * 5))
	liquid:SetParent(self)
	liquid.glass = self
	liquid:Spawn()

	self.liquid = liquid

end 

function ENT:AddDrink(drinkName , amount)

	local tab = util.JSONToTable(self:GetIngredients() , {})
	for i = 1 , amount do
		table.insert(tab , drinkName)
	end
	 
	

	local drinkAmount = #tab

	tab = util.TableToJSON(tab)
	self:SetIngredients(tab)
	self.liquid:SetGlassIngs(tab)
	self.liquid:SetLiquidAmount(drinkAmount)

end
