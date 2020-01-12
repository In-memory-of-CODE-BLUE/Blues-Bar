local p = FindMetaTable("Player")

include("bluebar/bottles.lua")

AddCSLuaFile("bluebar/recipies.lua")
AddCSLuaFile("bluebar/bottles.lua")
include("bluebar/recipies.lua")

util.AddNetworkString("UpdateBarStatus")
util.AddNetworkString("DisconnectBar")
util.AddNetworkString("DrinkToGlass")
util.AddNetworkString("GlassToCustomer")
 
--Saving and loading of bars
hook.Add("PlayerSay" , "SaveBluesBar" , function(ply , text)
	if string.lower(text) == "!savebars" then
		local hasPermision = false
		for k ,v in pairs(bbc.permision) do
			if ply:GetUserGroup() == v then
				hasPermision = true
				break
			end
		end
		if not hasPermision then return end
		local bars = ents.FindByClass("blue_bar")
		local bars_table = {}
		for k ,v in pairs(bars) do
			local b = {}
			b.pos = {x=v:GetPos().x,y=v:GetPos().y,z=v:GetPos().z} 
			b.ang = {p=v:GetAngles().pitch,y=v:GetAngles().yaw,r=v:GetAngles().roll}
			table.insert(bars_table , b)  
		end 
		local bar_table_json = util.TableToJSON(bars_table)
		file.Write("blues_bar.txt", bar_table_json)
		ply:ChatPrint("BARS SAVED!")
	end
		if string.lower(text) == "!unsavebars" then
		local hasPermision = false
		for k ,v in pairs(bbc.permision) do
			if ply:GetUserGroup() == v then
				hasPermision = true
				break
			end
		end 
		if not hasPermision then return end
		file.Write("blues_bar.txt", "")
		ply:ChatPrint("BARS UNSAVED!")
	end
end)
 
hook.Add( "InitPostEntity", "LoadBluesBars", function()
	local data = file.Read("blues_bar.txt" , false)
	if data == "" or data == nil then return end
	local dataTable = util.JSONToTable(data)
	for k , v in pairs(dataTable) do
		local t = ents.Create("blue_bar")
		t:SetPos(Vector(v.pos.x , v.pos.y , v.pos.z))
		t:SetAngles(Angle(v.ang.p , v.ang.y , v.ang.r))
		t:Spawn() 
	end
end )

net.Receive("GlassToCustomer" , function(len , ply)
	local ent = net.ReadEntity()  
	local customer = net.ReadEntity()
	if IsValid(customer) and IsValid(ent) then	
		if customer.owner == ent then			
			if ply.bb.isUsingBar and ply.bb.attachedBar == ent then
				customer:ReturnGlass()
			end
		end
	end
end)


net.Receive("DrinkToGlass",function(len , ply)


	local drink = net.ReadEntity()
	local glass = net.ReadEntity()
	local amount = net.ReadInt(4)
	if not ply.bb.isUsingBar then 
		return 
	end
	if amount == nil or amount < 0 or amount > 7 then
		return
	end

	if IsValid(drink) and drink:GetClass() == "blue_bottle" then

		if IsValid(glass) and glass:GetClass() == "blue_glass" then

			if not drink:GetIsBusy() and not glass:GetIsBusy() then

				local hasBottle = false

				for k , v in pairs(ply.bb.attachedBar.bottles) do

					if v.ent == drink then
						hasBottle = true
					end

				end

				if hasBottle then
					
					local hasGlass = false

					for k ,v in pairs(ply.bb.attachedBar.customers) do

						if v:GetGlass() == glass then
							hasGlass = true 
						end

					end

					if not hasGlass then return end

					local glassIngs = glass:GetIngredients()
					glassIngs = util.JSONToTable(glassIngs)

					--Now checkt o see if there is enought room for it

					local amountInGlass = table.Count(glassIngs)
					if amountInGlass + amount > 7 then
						return
					end

					drink:SetIsBusy(true)
					glass:SetIsBusy(true) 
					glass:AddDrink(drink:GetBottleName() , amount)
					drink:PourAnimation(glass , amount)

				end

			end

		end

	end

end)

hook.Add("PlayerInitialSpawn" , "bb_config_player" , function(ply)

	ply.bb = {}
	ply.bb.isUsingBar = false
	ply.bb.attachedBar = nil

end)

function p:bb_Detatch()

	if self.bb.isUsingBar then
		
		self:SetActiveWeapon(self.prevWep)

		self:DrawViewModel(true , 0)
		self:DrawViewModel(true , 1)
		self:DrawViewModel(true , 2)

		--self:UnLock()
		self:Freeze(false)
		self.bb.isUsingBar = false
		self.bb.attachedBar:OnDetached()
		self.bb.attachedBar = nil
		
		net.Start("UpdateBarStatus")
			net.WriteBool(false) 
			net.WriteEntity(self)
		net.Send(self)
	end
end

net.Receive("DisconnectBar" , function(len , ply)
	if ply.bb.isUsingBar then
		ply:bb_Detatch()
	end
end)

function p:bb_Attach(e)

	if self.bb.isUsingBar == false and e:GetClass() == "blue_bar" and e.attachedPlayer == nil  then
		local isAllowed = false
		for k , v in pairs(bbc.allowedJobs) do
			if self:Team() == v then
				isAllowed = true
			end
		end 
		if not isAllowed then  
			self:ChatPrint("Your job is not allowed to use this.")
			return 
		end 
		self:DrawViewModel(false , 0)
		self:DrawViewModel(false , 1)
		self:DrawViewModel(false , 2)

		self.prevWep = self:GetActiveWeapon()
		self:SetActiveWeapon("keys")

		self.bb.isUsingBar = true
		self.bb.attachedBar = e 

 
		local plyPos = e:GetAngles():Forward() * 33 
		--plyPos = plyPos + e:GetAngles():Right() * -1.88
		--self:Lock() 
		self:Freeze(true)
		self:SetPos(e:GetPos() - plyPos)
		self:SetEyeAngles(e:GetAngles())


		e:OnAttached(self) 

		net.Start("UpdateBarStatus")
			net.WriteBool(true)
			net.WriteEntity(e) 
			net.WriteTable(e.bottles) 
		net.Send(self)
		self:SetPos(e:GetPos() - plyPos)
		self:SetEyeAngles(e:GetAngles())

	end

end
 
hook.Add("PlayerDeath" , "DettachFromBar" , function(ply)
	ply:bb_Detatch()
end)
hook.Add("PlayerDisconnected" , "DettachFromBar" , function(ply)
	ply:bb_Detatch() 
end)