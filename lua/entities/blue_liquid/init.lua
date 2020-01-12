AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()


	self:SetModel("models/blues-bar/drink.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )
	self:SetMaterial("blues-bar/blue_liquid")   
	self:SetSolid( SOLID_NONE )       
	self:SetUseType(SIMPLE_USE)  

	self:SetColor(Color(math.random(255),math.random(255),math.random(255)))
	self:SetGlassIngs(util.TableToJSON({}))

	self:SetLiquidAmount(0)

end
