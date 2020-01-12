AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

util.AddNetworkString("BottleAnimation")


local customerSpaces = {}
customerSpaces[1] = {pos = Vector(0,45,0) , ang = Angle(0,180,0)}
customerSpaces[2] = {pos = Vector(40,45,0) , ang = Angle(0,160,0)}
customerSpaces[3] = {pos = Vector(-40,45,0) , ang = Angle(0,200,0)}

function ENT:Initialize()

	self:SetModel( "models/blues-bar/bar.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )       
	self:SetUseType(SIMPLE_USE)  
	self.customers = {}
 	self.inUse = false
 	self.spawnTime = 0
 	self.nextSpawnTime = 0
 	self.attachedPlayer = nil
  local phys = self:GetPhysicsObject()

	--if (phys:IsValid()) then
	--	phys:Wake()
	--end

	self:SetUpDrinks()


end

function ENT:VectorToOffset(v)

	local ang = self:GetAngles()
	local nv = (ang:Right()*v.x) + (ang:Forward()*v.y) + (ang:Up()*v.z) + self:GetPos()
	return nv

end

function ENT:AngleToOffset(v)

	local p = v.p
	local y = v.y
	local r = v.r
	local ang = self:GetAngles()
	local na = Angle(ang.p + p , ang.y + y , ang.r + r)
	return na

end

function ENT:Use(c , ply)

	ply:bb_Attach(self)

end

function ENT:OnAttached(ply)

	self.inUse = true
	self.attachedPlayer = ply
	self:SetInUse(true)

end

function ENT:OnDetached()

	self.inUse = false 
	self.attachedPlayer = nil
		self:SetInUse(false)
	for k , v in pairs(self.customers) do
		
		if v ~= nil then
			v:Remove()
		end

	end

	self.customers = {}

end

function ENT:SetUpDrinks()

	local xWidth = 28
	self.bottles = {}

	--Row 1
	for k , v in pairs(bb_bottles.row1) do
		
		local pos = Vector(25 , xWidth - (((xWidth * 2) / table.Count(bb_bottles.row1))) * (k - 0.5) , 29)
		local t = ents.Create("blue_bottle")
		t:SetBottleInfo(v.name , v.bottleType , v.bottleMat, v.glassMat, v.desc , self)
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetAngles():Right(), 90)
		t:SetAngles(ang)
		t:SetPos(LocalToWorld(pos , ang , self:GetPos() , self:GetAngles()))
		t:SetParent(self)
		t:Spawn()

		self.bottles[t:EntIndex()] = {}
		self.bottles[t:EntIndex()].ent = t
		self.bottles[t:EntIndex()].hovered = false
		self.bottles[t:EntIndex()].origin = pos

	end

	--Row 2

	for k , v in pairs(bb_bottles.row2) do
		
		local pos = Vector(25 , xWidth - (((xWidth * 2) / table.Count(bb_bottles.row2))) * (k - 0.5) , 18)
		local t = ents.Create("blue_bottle")
		t:SetBottleInfo(v.name , v.bottleType , v.bottleMat, v.glassMat, v.desc , self)
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetAngles():Right(), 90)
		t:SetAngles(ang)
		t:SetPos(LocalToWorld(pos , ang , self:GetPos() , self:GetAngles()))
		t:SetParent(self)
		t:Spawn()

		self.bottles[t:EntIndex()] = {}
		self.bottles[t:EntIndex()].ent = t
		self.bottles[t:EntIndex()].hovered = false
		self.bottles[t:EntIndex()].origin = pos

	end

	--Row 2

	for k , v in pairs(bb_bottles.row3) do
		
		local pos = Vector(25 , xWidth - (((xWidth * 2) / table.Count(bb_bottles.row3))) * (k - 0.5) , 7.5)
		local t = ents.Create("blue_bottle")
		t:SetBottleInfo(v.name , v.bottleType , v.bottleMat, v.glassMat, v.desc , self)
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetAngles():Right(), 90)
		t:SetAngles(ang)
		t:SetPos(LocalToWorld(pos , ang , self:GetPos() , self:GetAngles()))
		t:SetParent(self)
		t:Spawn()

		self.bottles[t:EntIndex()] = {}
		self.bottles[t:EntIndex()].ent = t
		self.bottles[t:EntIndex()].hovered = false
		self.bottles[t:EntIndex()].origin = pos

	end

end


////////////////////////////////////////
//Customer management stuff below here//
////////////////////////////////////////

function ENT:Think()

	if self.inUse ~= true then return end

	if self.spawnTime <= CurTime() then
		
		self.spawnTime = CurTime() + (math.random(bbc.minCustomerTime * 60.0 , bbc.maxCustomerTime * 60.0))

		if self:EmptySpace() then

			local spaceID = self:GetEmptySpace()
			local space = customerSpaces[spaceID]

			local temp = ents.Create("blue_customer")
			temp:SetAngles(self:AngleToOffset(space.ang))
			temp:SetPos(self:VectorToOffset(space.pos))
			temp:Spawn()
			temp.owner = self
			temp.id = spaceID

			self.customers[spaceID] = temp

		end

	end

end

function ENT:RemoveCustomer(id)

	self.customers[id] = nil

end

--Checks if an empty space exist for a customer
function ENT:EmptySpace()

	local empty = false

	for i = 1 , 3 do
		
		if self.customers[i] == nil then
			
			empty = true

		end

	end

	return empty

end

--Returns a random empty space for a customer
function ENT:GetEmptySpace()

	local spaces = {}

	for i = 1 , 3 do
		if self.customers[i] == nil then
			table.insert(spaces , i)
		end
	end

	return spaces[math.random(#spaces)] or -1

end

