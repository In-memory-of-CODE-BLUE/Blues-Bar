include("bluebar/recipies.lua")
include("bluebar/bottles.lua")

local isAttached = false
local attachedBar = nil
local lockedEyePos = Angle(0,0,0)
local canInteract = true

local bottles = {}

local minX , maxX = -55 , 55
local minY , maxY = -55 , 55

local xAng = 0
local yAng = 0

local selectedEntitie

local bottleInfoAlpha = 0
local hoveringOverBottle = false

local hoveringOverGlass = false
local hoveredGlass = nil
local glassInfoAlpha = 0

local selectFade = {
	Color(120,255,120),
	Color(120,120,255)
}

surface.CreateFont( "BotleInfoFont", {
	font = "Nexa Light",
	size = 40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "GlassInfoFont1", {
	font = "Nexa Light",
	size = 75,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "GlassInfoFont2", {
	font = "Nexa Light",
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BBButtonFont", {
	font = "Nexa Light",
	size = 35,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "BBButtonFont2", {
	font = "Nexa Light",
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

net.Receive("UpdateBarStatus" , function()

	isAttached = net.ReadBool()
	attachedBar = net.ReadEntity()
	if isAttached then		
		bottles = net.ReadTable()
	end
	lockedEyeAng = LocalPlayer():EyeAngles()
	xAng = 0
	yAng = 0
	gui.EnableScreenClicker(isAttached)
end)

local recBut = nil
local helpBut = nil
local closeBut = nil
local rec_mat = Material("blues-bar/rec_icon.png","noclamp smooth")
local help_mat = Material("blues-bar/help_icon.png","noclamp smooth")
local close_mat = Material("blues-bar/close_icon.png" , "noclamp smooth")
function bb_onAttached()

	recBut = vgui.Create("DButton")
	recBut:SetPos(ScrW() - 64 , ScrH()/2 + 10)
	recBut:SetSize(64 + 150 , 64)
	recBut:SetText("")
	recBut.Paint = function(s , w ,h)
		draw.RoundedBox(0,15,0,w - 15 , 64 , Color(180,180,180,255))
		draw.RoundedBox(0,64,0,w - 64 , 64 , Color(40,40,40,255))
		draw.SimpleText("Recipies","BBButtonFont",64 + (150 /2),64/2,Color(180,180,180,255),1,1)
		surface.SetDrawColor(40,40,40,255)
		surface.SetMaterial(rec_mat)
		surface.DrawTexturedRect(0,0,64,64)
	end 
	recBut.DoClick = function()
		openRecipieBrowser()
	end
	recBut.Think = function(s)
		if s:IsHovered() then		
			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64 - 150) , y)
		else
			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64) , y)
		end
	end
	recBut:SetVisible(true)
	helpBut = vgui.Create("DButton")
	helpBut:SetPos(ScrW() - 64 , ScrH()/2 + 10 + 74)
	helpBut:SetSize(64 + 150 , 64)
	helpBut:SetText("")
	helpBut.Paint = function(s , w ,h)
		draw.RoundedBox(0,15,0,w - 15 , 64 , Color(180,180,180,255))
		draw.RoundedBox(0,64,0,w - 64 , 64 , Color(40,40,40,255))
		draw.SimpleText("Help","BBButtonFont",64 + (150 /2),64/2,Color(180,180,180,255),1,1)
		surface.SetDrawColor(40,40,40,255)
		surface.SetMaterial(help_mat)
		surface.DrawTexturedRect(0,0,64,64)
	end 
	helpBut.DoClick = function() 
		OpenHelpBrowser()
	end
	helpBut.Think = function(s)

		if s:IsHovered() then
			
			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64 - 150) , y)

		else

			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64) , y)

		end

	end
	helpBut:SetVisible(true)

	closeBut = vgui.Create("DButton")
	closeBut:SetPos(ScrW() - 64 , ScrH()/2 + 10 + 74 + 74)
	closeBut:SetSize(64 + 150 , 64)
	closeBut:SetText("")
	closeBut.Paint = function(s , w ,h)

		draw.RoundedBox(0,20,15,w - 15 , 64 - 20 , Color(180,180,180,255))
		draw.RoundedBox(0,64,0,w - 64 , 64 , Color(40,40,40,255))

		draw.SimpleText("Exit","BBButtonFont",64 + (150 /2),64/2,Color(180,180,180,255),1,1)

		surface.SetDrawColor(40,40,40,255)
		surface.SetMaterial(close_mat)
		surface.DrawTexturedRect(0,0,64,64)

	end 
	closeBut.DoClick = function()

		net.Start("DisconnectBar")
		net.SendToServer()

	end
	closeBut.Think = function(s)

		if s:IsHovered() then
			
			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64 - 150) , y)

		else

			local x , y = s:GetPos()
			s:SetPos(Lerp(16*FrameTime() , x , ScrW() - 64) , y)

		end

	end
	closeBut:SetVisible(true)

end

function bb_onDettatched()

	recBut:Remove()
	helpBut:Remove()
	closeBut:Remove()

	if recipiesFrame ~= nil then
		
		recipiesFrame:Close()

	end
	if isHelpOpen then
		helpFrame:Close()
	end

end

local prevAttached = false
hook.Add("Think" , "attachmentHandler" , function()

	if prevAttached ~= isAttached then
		if isAttached then
			bb_onAttached()
		else
			bb_onDettatched()
		end
	end

	prevAttached = isAttached

end)

function lerpCol(t , a , b)

	return Color(
		Lerp(t , a.r , b.r),
		Lerp(t , a.g , b.g),
		Lerp(t , a.b , b.b)
	)

end

local sinAng = 0
hook.Add( "PreDrawHalos", "AddHalos", function()

	sinAng = sinAng + (6*FrameTime())

	local c = lerpCol((math.sin(sinAng) + 1) / 2 , selectFade[1] , selectFade[2])

	if IsValid(selectedEntitie) then

		halo.Add({selectedEntitie}, c, 2, 2, 5 , true , true )

	end



end )

function GetGlassFormatedIngredients(g)

	if g:IsValid() and g:GetClass() == "blue_glass" then
		
		local ings = util.JSONToTable(g:GetIngredients())

		if ings == nil then return {} end
		
		local newIngs = {}

		for k ,v in pairs(ings) do
			
			if newIngs[v] == nil then
				newIngs[v] = 1
			else
				newIngs[v] = newIngs[v] + 1
			end

		end

		return newIngs

	end

end

hook.Add("HUDPaint" , "DrawBottleInfo" , function()

	if hoveringOverBottle then

		bottleInfoAlpha = Lerp(8*FrameTime() , bottleInfoAlpha , 255)

	else

		bottleInfoAlpha = 0

	end

	for k , v in pairs(bottles) do
	
		if v.hovered then

			local v = v.ent 

			local ang = v:GetAngles()

			ang:RotateAroundAxis(v:GetAngles():Forward(),90)
			ang:RotateAroundAxis(v:GetAngles():Up(),-90)
			ang:RotateAroundAxis(v:GetAngles():Right(),-(180 - 45))

			cam.Start3D()

				cam.Start3D2D(v:GetPos() + (v:GetAngles():Forward() * 5) + (v:GetAngles():Up() * 20) - (v:GetAngles():Right() * ((300/2)*0.042)) , ang, 0.045)



					draw.RoundedBox(4,0 , 0 , 300 ,45,Color(40,40,40 , bottleInfoAlpha))
					
					draw.SimpleText(v:GetBottleName(),"BotleInfoFont",300/2 , (45/2) - 2,Color(210,210,210),1,1)

				cam.End3D2D()

			cam.End3D()

		end

	end

	if hoveringOverGlass then
		
		if not hoveredGlass:IsValid() then return end

		glassInfoAlpha = Lerp(16*FrameTime() , glassInfoAlpha , 255)

		local g = hoveredGlass

		local ang = g:GetAngles()

		ang:RotateAroundAxis(g:GetAngles():Forward(),90)
		ang:RotateAroundAxis(g:GetAngles():Up(),90)

		cam.Start3D()

			cam.Start3D2D(g:GetPos() + (g:GetAngles():Forward() * 0) + (g:GetAngles():Up() * 8) - (g:GetAngles():Right() * 5) , ang, 0.045)

				local ings = GetGlassFormatedIngredients(g)

				local xPos = 0
				local count = table.Count(ings)
				if count > 0 then

					draw.RoundedBox(24,0 , 0 , 500 ,85 + (count * 42),Color(40,40,40 , glassInfoAlpha))

					for k ,v in pairs(ings) do
						
						draw.SimpleText(k,"GlassInfoFont2",10 , 85 + (xPos * 38),Color(210,210,210 , glassInfoAlpha),0,1)
						draw.SimpleText((v * 10).."ml","GlassInfoFont2",500 - 10 , 85 + (xPos * 38),Color(210,210,210 , glassInfoAlpha),2,1)

						xPos = xPos + 1.12

					end

				else

					draw.RoundedBox(4,0 , 0 , 500 ,75 + 35,Color(40,40,40 , glassInfoAlpha))

					draw.SimpleText("Empty...","GlassInfoFont2",500/2 , 64,Color(210,210,210 , glassInfoAlpha),1,0)

				end
				
				draw.SimpleText("Glass Contents","GlassInfoFont1",500/2 , 2 ,Color(210,210,210 , glassInfoAlpha),1,0)

			cam.End3D2D()

		cam.End3D()


	else

		glassInfoAlpha = 0

	end

end)

local prevEnt = nil

local ePressed = false
local pressedMouseButton = false
local pressedMouseButton2 = false

hook.Add("Think" , "HandleBottleAnimations" , function()


	if not isAttached then 
		selectedEntitie = nil 
	end

	if not IsValid(selectedEntity) then
		selectedEntity = nil
	end

	if isAttached then
	
		local ffilter = ents.FindByClass("blue_bar")
		table.insert(ffilter , LocalPlayer()) 
		local tr = util.QuickTrace( LocalPlayer():GetShootPos(), gui.ScreenToVector( gui.MousePos() ) * 10000, ffilter )
		
		if IsValid(tr.Entity) then
			
			if tr.Entity:GetClass() == "blue_glass" then
					
				hoveringOverGlass = true
				hoveredGlass = tr.Entity

			else

				hoveringOverGlass = false
				hoveredGlass = nil						

			end

		end

		if input.IsMouseDown(107) and canInteract then
			
			if pressedMouseButton == false then
				
				pressedMouseButton = true
 
				if tr.Entity ~= NULL then 
					if tr.Entity:GetClass() == "blue_bottle" or tr.Entity:GetClass() == "blue_glass" or tr.Entity:GetClass() == "blue_customer" then
						if selectedEntitie == nil then
							if tr.Entity:GetClass() ~= "blue_customer" then							
								selectedEntitie = tr.Entity
							end
						else
							if selectedEntitie:GetClass() == "blue_bottle" then
								if tr.Entity:GetClass() == "blue_glass" then
									if tr.Entity:GetIsBusy() == false then
										canInteract = false
										createDrinkAmountSelection(selectedEntitie , tr.Entity)									
									else
										LocalPlayer():ChatPrint("A Drink is already being poured into this glass.")
									end
								end							
							elseif selectedEntitie:GetClass() == "blue_glass" then							
								if tr.Entity:GetClass() == "blue_customer" then								
									--THEY TRIED TO GIVE A DRINK TO CUSTOMER
									net.Start("GlassToCustomer")
										net.WriteEntity(attachedBar)
										net.WriteEntity(tr.Entity)
									net.SendToServer()
									selectedEntitie = nil
								end
							end
						end
					end
				end
			end
		else
			pressedMouseButton = false
		end

		if input.IsMouseDown(108) then
			if pressedMouseButton2 == false then				
				selectedEntitie = nil
			end
		else
			pressedMouseButton2 = false
		end
		if tr.Entity ~= prevEnt then
			if prevEnt ~= nil and bottles[prevEnt:EntIndex()] ~= nil then
				bottles[prevEnt:EntIndex()].hovered = false
				hoveringOverBottle = false
			end

			if IsValid(tr.Entity) and tr.Entity:GetClass() == "blue_bottle" then

				bottles[tr.Entity:EntIndex()].hovered = true
				hoveringOverBottle = true
				prevEnt = tr.Entity

			end

			if IsValid(tr.Entity) == false or tr.Entity:GetClass() ~= "blue_bottle" then
				
				prevEnt = nil

			end

		end

		for k , v in pairs(bottles) do
			
			if not v.ent:GetIsBusy() then

				if v.hovered then
					
					v.ent:SetPos(LerpVector(FrameTime() * 7 , v.ent:GetPos() , LocalToWorld(v.origin , v.ent:GetAngles() , attachedBar:GetPos() , attachedBar:GetAngles()) + (attachedBar:GetAngles():Forward() * -8)))

				else

					v.ent:SetPos(LerpVector(FrameTime() * 7 , v.ent:GetPos() , LocalToWorld(v.origin , v.ent:GetAngles() , attachedBar:GetPos() , attachedBar:GetAngles())))

				end

			end

		end

	end

end)

function bb_SetLookDir( ply, pos, angles, fov )
	
	if isAttached then

		local x = gui.MouseX() / ScrW()
		local y = gui.MouseY() / ScrH()

		xAng = Lerp(55*FrameTime() , xAng , Lerp(x , minX , maxX) * -1)
		yAng = Lerp(55*FrameTime() , yAng , Lerp(y , minY , maxY))

		local pitch , yaw , roll = angles.p , angles.y , angles.r
		pitch = pitch + yAng
		yaw = yaw + xAng

		local finalAng = Angle(pitch, yaw , roll)

		local view = {}
		view.origin = pos
		view.angles = finalAng
		view.fov = fov
		return view

	end

end

hook.Add( "CalcView", "bb_SetLookDir", bb_SetLookDir)

--Recipie browser down here

surface.CreateFont( "RPBrowser_1", {
	font = "Nexa Light",
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "RPBrowser_2", {
	font = "Nexa Light",
	size = 17,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local isRecipieOpen = false
local recipiesFrame = nil
local recipiesPanel = nil
local searchBox = nil

function getValidRecipies(st)

	local data = {}

	st = string.lower(st)
	if st == "search..." then

		for k ,v in pairs(bb_recipies) do

			table.insert(data , k)

		end

		return data

	end


	for k ,v in pairs(bb_recipies) do
		
		local name = string.lower(k)

		if string.find(name , st) then
			
			table.insert(data , k)

		end

	end

	return data

end

function createRecipiesPanel()

	if recipiesPanel ~= nil then
		recipiesPanel:Remove()
		recipiesPanel = nil
	end

	local items = getValidRecipies(searchBox:GetValue())
	local itemCount = #items

	recipiesPanel = vgui.Create("DScrollPanel" , recipiesFrame)
	recipiesPanel:SetPos(10 , 60 + 10)
	recipiesPanel:SetSize(300 - 20 , 400 - 60 - 10 - 10)
	recipiesPanel.itemCount = itemCount
	recipiesPanel.Paint = function(s , w, h) 

	local sbar = recipiesPanel:GetVBar()
	function sbar:Paint( w, h )

		draw.RoundedBox( 0, w - 8, 0, 8, h, Color( 40,40,40,255 ) )

	end
	function sbar.btnUp:Paint( w, h )

		draw.RoundedBox( 0, w - 8, 0, 8, h, Color( 0,0,0 ) )

	end
	function sbar.btnDown:Paint( w, h )

		draw.RoundedBox( 0, w - 8, 0, 8, h, Color( 0,0,0 ) )

	end
	function sbar.btnGrip:Paint( w, h )

		draw.RoundedBox( 0, w - 8, 0, 8, h, Color( 80,80,80 ) )

	end

		if s.itemCount < 1 then

			draw.SimpleText("No Drink Found :c", "RPBrowser_1",w/2 , h/2,Color(180,180,180),1,1)

		end
 
	end
 
	if itemCount > 0 then
		
		local xPos = 10

		for k , v in pairs(items) do 
			
			local t = vgui.Create("DButton",recipiesPanel)
			t:SetSize(300 - 20 - 20 , 75)
			t:SetPos(10 , xPos)
			t:SetText("") 
			t.itemName = v
			t.showIngs = false
			t.itemRecipie = bb_recipies[v]
			t.drawPos = 0
			t.Paint = function(s , w ,h)

				draw.RoundedBox(12,0,0,w,h,Color(40,40,40))

				draw.SimpleText(s.itemName, "RPBrowser_1",s.drawPos + (w/2) , h/2,Color(180,180,180),1,1)

				local x = 260
				local yPos = 1
					
				for k ,v in pairs(s.itemRecipie) do
					
					draw.SimpleText(k, "RPBrowser_2",s.drawPos + x + 10, yPos,Color(180,180,180),0,0)
					draw.SimpleText((v * 10).."ml", "RPBrowser_2",s.drawPos + x + w - 10, yPos,Color(180,180,180),2,0)
					yPos = yPos + 15

				end

			end
			t.DoClick = function(s)

				s.showIngs = not s.showIngs

			end
			t.Think = function(s)

				if s.showIngs then
					
					t.drawPos = Lerp(10*FrameTime() , t.drawPos , -260)

				else

					t.drawPos = Lerp(10*FrameTime() , t.drawPos , 0)

				end

			end

			xPos = xPos + 85

		end

	end

end
local isHelpOpen = false
local helpFrame = nil
function OpenHelpBrowser()

	if isHelpOpen then return end

	isHelpOpen = true
 
	helpFrame = vgui.Create("DFrame")
	helpFrame:SetSize(300 , 400)
	helpFrame:Center()
	helpFrame:SetTitle("")
	helpFrame:SetVisible(true)
	helpFrame:MakePopup()
	helpFrame:ShowCloseButton(false)
	helpFrame.Close = function(s)
		isHelpOpen = false
		s:Remove()
	end
	local closeButton = vgui.Create("DButton",helpFrame)
	closeButton:SetPos(300-30 , 5)
	closeButton:SetSize(25,25)
	closeButton:SetText("")
	closeButton.Paint = function(s , w , h) 
		 draw.SimpleText("X","BBButtonFont2",w/2 , h/2 , Color(200,200,200) , 1,1)
	end
	closeButton.DoClick = function()
		helpFrame:Close() 
	end
	helpFrame.Paint = function(s , w , h)
		draw.RoundedBox(16,0,0,w,h,Color(40,40,40))
		draw.SimpleText("HELP","RPBrowser_2",300 / 2,8,Color(180,180,180,255),1,0)
		surface.SetDrawColor(0,0,0,255)
	end 

	local rt = vgui.Create("RichText",helpFrame)
	rt:SetPos(10,30)
	rt:SetSize(280 , 400 - 40)
	rt:AppendText([[Welcome to Blue's Bars.
 
In this tutorial I'll be explaining the very basics.
 
Over time customers will appear at your bar, they will have an emotion and a drink request
there emotion goes down over time until they leave your bar so think of it as a time limit.
To find the drink the customer wants click on the drink icon on the right side of the screen
from here you can search for drinks and click on them for there recipe.
 
Use left click to select ingredients and left click on a glass to fill it up a certain amount with
that ingredient to deselect an ingredient right click. Once done you can left click on the glass
and left click on the customer you're serving it to. And you're done! you've served your first
customer! keep in mind that if you serve them an incorrect drink you will not be paid. 
 
Finally once you're done serving and want to take a break you can click on the x button on the
right side of the screen to exit out of the bar.]])  

end

function openRecipieBrowser()

	if isRecipieOpen then return end

	isRecipieOpen = true
 
	recipiesFrame = vgui.Create("DFrame")
	recipiesFrame:SetSize(300 , 400)
	recipiesFrame:Center()
	recipiesFrame:SetTitle("")
	recipiesFrame:SetVisible(true)
	recipiesFrame:MakePopup()
	recipiesFrame:ShowCloseButton(false)
	recipiesFrame.Close = function(s)
		isRecipieOpen = false
		s:Remove()
	end
	local closeButton = vgui.Create("DButton",recipiesFrame)
	closeButton:SetPos(300-30 , 5)
	closeButton:SetSize(25,25)
	closeButton:SetText("")
	closeButton.Paint = function(s , w , h) 
		 draw.SimpleText("X","BBButtonFont2",w/2 , h/2 , Color(200,200,200) , 1,1)
	end 
	closeButton.DoClick = function()
		recipiesFrame:Close()
	end
	recipiesFrame.Paint = function(s , w , h)
		draw.RoundedBox(16,0,0,w,h,Color(40,40,40))
		draw.SimpleText("RECIPES","RPBrowser_2",300 / 2,8,Color(180,180,180,255),1,0)
		surface.SetDrawColor(0,0,0,255)
		--For the text box background
		draw.RoundedBox(12,9,29,282 , 29,Color(0,0,0))
		draw.RoundedBox(12,10,30,280 , 27,Color(60,60,60))
 
		--For the list background
		draw.RoundedBox(12 , 9 , 69 , 300 - 20 + 2, 400 - 60 - 10 - 10 + 2,Color(0,0,0))
		draw.RoundedBox(12 , 10 , 70 ,300 - 20 , 400 - 60 - 10 - 10,Color(60,60,60))

		--surface.DrawOutlinedRect(10,30 , 280 , 27)

	end

	searchBox = vgui.Create("DTextEntry",recipiesFrame)
	searchBox:SetPos(15 , 32)
	searchBox:SetSize(280 - 5 , 27)
	searchBox:SetDrawBackground(false)
	searchBox:SetCursorColor(Color(180,180,180))
	searchBox:SetFont("RPBrowser_1")
	searchBox:SetValue("Search...")
	searchBox.OnChange = createRecipiesPanel
	searchBox.Think = function(s)

		if s:GetValue() == "Search..." then
			
			s:SetTextColor(Color(90,90,90))

		else

			s:SetTextColor(Color(180,180,180))

		end

	end

	createRecipiesPanel()

end

function createDrinkAmountSelection(drink, glass)

	local frame = vgui.Create("DFrame")
	frame:SetSize(250,80)
	frame:Center()
	frame:SetTitle("") 
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Close = function(s)
		selectedEntitie = nil
		canInteract = true
		s:Remove()
	end
	frame.Paint = function(s , w , h) 
		draw.RoundedBox(12,0,0,w,h,Color(40,40,40)) 
	end
	local closeButton = vgui.Create("DButton",frame)
	closeButton:SetPos(250-30 , 2) 
	closeButton:SetSize(25,25)
	closeButton:SetText("")
	closeButton.Paint = function(s , w , h) 
		 draw.SimpleText("X","BBButtonFont2",w/2 , h/2 , Color(200,200,200) , 1,1)
	end
	closeButton.DoClick = function(s)
		s:GetParent():Close()
	end

	local amountPanel = vgui.Create("DButton",frame)
	amountPanel:SetText("")
	amountPanel:SetPos(10,25)  
	amountPanel:SetSize(230,20) 
	amountPanel.OnMousePressed = function(s)
		s.isDraggin = true 
	end 
	amountPanel.isDraggin = false
	amountPanel.Think = function(s)
		if s.isDraggin then  
			s.val = s:CursorPos() / s:GetWide()
			s.val = math.Clamp(s.val,0,1)
		end  
	end   
	amountPanel.OnMouseReleased = function(s)
		s.isDraggin = false
	end 
	amountPanel.val = 0.5
	amountPanel.Paint = function(s , w , h) 
		v = math.Round(((s.val * 7) / 7) * 7)   / 7
		draw.RoundedBox(0,0,0,w,h,Color(80,80,80)) 
		draw.RoundedBox(0,1,1,v * w - 2,h - 2,Color(40,200,40)) 
		 draw.SimpleText((math.Round(((amountPanel.val * 7) / 7) * 7) * 10).." ML","BBButtonFont2",w/2 , h/2 , Color(2255,255,255) , 1,1)

	end 
 
 	local pourButton = vgui.Create("DButton" , frame) 
 	pourButton:SetPos(30 , 50)
 	pourButton:SetSize(250 - 60 , 25)
 	pourButton:SetText("")
 	pourButton.Paint = function(s , w ,h )

 		draw.RoundedBox(12,0,0,w,h,Color(60,60,60))
 		draw.SimpleText("Pour Drink","BBButtonFont2",w/2 , h/2 , Color(200,200,200) , 1,1)

	end
	pourButton.drink = drink
	pourButton.glass = glass
	pourButton.frame = frame
	pourButton.slider = NumSliderr
	pourButton.DoClick = function(s)
		if math.Round(((amountPanel.val * 7) / 7) * 7) > 0 and math.Round(((amountPanel.val * 7) / 7) * 7) < 8 then
			net.Start("DrinkToGlass")
				net.WriteEntity(s.drink)
				net.WriteEntity(s.glass)   
				net.WriteInt(math.Round(((amountPanel.val * 7) / 7) * 7) , 4)
			net.SendToServer() 
			frame:Close()
		end
	end 
end