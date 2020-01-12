AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include('blues_bar_config.lua')

function ENT:Initialize()

	local model = bbc.customerModels[math.random(#bbc.customerModels)]
	self:CapabilitiesAdd(CAP_ANIMATEDFACE) 
	self:CapabilitiesAdd(CAP_TURN_HEAD) 
	self:SetModel(model)
	self:SetHullType(HULL_HUMAN) 
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetBloodColor(BLOOD_COLOR_RED)
	self.emotionTimer = CurTime() + (bbc.emotionTimeStep * 60)
	self:SetEmotion(4)
	self:SetIsDying(false)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON) 
	--Spawn the glass

	local glass = ents.Create("blue_glass")
	glass:SetPos(self:GetPos() + (self:GetAngles():Up() * 37.5) + (self:GetAngles():Forward() * 27))
	glass:Spawn()
	glass:SetParent(self)

	self.glass = glass
	self:SetGlass(self.glass)
	self.glass:SetAngles(self:GetAngles())
 
	local wantedDrinkNumber = math.random(1 , table.Count(bb_recipies))
	local c = 1

	local drinkName = "No Drink"

	for k ,v in pairs(bb_recipies) do

		if c == wantedDrinkNumber then

			drinkName = k

		end
 
		c = c + 1

	end 
	self:SetWantedDrink(drinkName) 

end

function ENT:DisplayMessage(type , message)

	local t = ents.Create("blue_message")
	t:SetPos(self:GetPos() + Vector(0,0,100))
	t:SetAngles(self:GetAngles())
	t:SetMessageType(type)
	t:SetMessageText(message) 
	t:Spawn()

end

function ENT:ReturnGlass()

	local g = self:GetGlass()

	if not g:GetIsBusy() then

		local neededIngs = bb_recipies[self:GetWantedDrink()]

		local currentIngs = {}
		 
		for k ,v in pairs(util.JSONToTable(g:GetIngredients())) do
			
			if currentIngs[v] == nil then

				currentIngs[v] = 1

			else

				currentIngs[v] = currentIngs[v] + 1

			end

		end

		local correctIngs = false

		if table.Count(currentIngs) == table.Count(neededIngs) then
			
			correctIngs = true

		end

		for k ,v in pairs(neededIngs) do
			
			if currentIngs[k] ~= v then

				correctIngs = false

			end

		end

		--Correct ings will only be true if everything matches.

		if correctIngs then
			local payout = 0
			if self:GetEmotion() > 0 then
				payout = (bbc.payout/4) *  self:GetEmotion() 
				self.owner.attachedPlayer:addMoney(payout) 
				self:DisplayMessage(1 , "+$"..payout)
			end
		else 
				self:DisplayMessage(2 , "WRONG INGREDIENTS!")
		end

		g:Remove()
		self:SetIsDying(true) 
		self:KillCustomer()

	end

end

function ENT:KillCustomer()

	timer.Simple(1 ,function()

		self.owner:RemoveCustomer(self.id)
		self:Remove()

	end)

end
 

function ENT:Think()

	if self:GetIsDying() then
		
		if self.emotionTimer + 1 < CurTime() then
			
			self.owner:RemoveCustomer(self.id)
			self:Remove()

		end

		return

	end

	if self.emotionTimer < CurTime() then
		
		self.emotionTimer = CurTime() + (bbc.emotionTimeStep * 60)

		if self:GetEmotion() - 1 == 0 and self:GetIsDying() == false then
			local expresions = { --Add more if you wish
				"Screw this im out!",
				"Your so slow, goodbye!",
				"You took to long, Im going."
			}
			self:SetIsDying(true) 
			self:DisplayMessage(2 , expresions[math.random(1,#expresions)])
			self:KillCustomer()
			self.glass:Remove()

			return

		end

		self:SetEmotion(self:GetEmotion() - 1)
 
	end

end
