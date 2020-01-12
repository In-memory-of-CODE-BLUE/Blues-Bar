//////////////////////////////////
/////PLEASE REAS THIS FIRST///////
//////////////////////////////////

--1. Place any amount of bars you want around the map by spawning "BAR" from the q menu located under blues bars
--2. Once you are happy with the placement you can do "!savebars" in chat to save them permanently (If you have permmision below)
--3. If you are unhappy or need to change these placements do "!unsavebars" and this will unsave them all, Then move and save again.
--4. Once you happy with it all you can them configure stuff below to get the best experience.
--5*.(NOT RECOMMENDED) You can add your own receipies by going into bluebar/recipies.lua (Altough its self explainitory just be careful)
--6*.(NOT RECOMMENDED) You can also add you own bottles by going into bluebar/bottles.lua but im not going to explain how to do this as the addon was never intended to be done, But anyone with basic Lua knowlage should be able to figure out how that works and be able to set up custom bottles themselfs.
--7. Enjoy your new addon.

bbc = {}
bbc.permision = { --This is a list of ULX ranks that can use the chat commands to save or remove bars from the map (For permanent placement)
	"superadmin",
	"owner", 
	"developer"
}
bbc.customerModels = { --This is a list of 'ragdoll' models that can apear at the bar as a customer
	"models/Humans/Group03/Male_05.mdl",
	"models/Humans/Group01/Female_04.mdl",
	"models/Humans/Group02/male_03.mdl",
	"models/Humans/Group02/Male_04.mdl",
	"models/Humans/Group02/male_08.mdl",
	"models/Humans/Group01/Female_02.mdl",
	"models/Humans/Group02/Female_07.mdl",
	"models/Humans/Group03/male_09.mdl",
	"models/Humans/Group03m/Female_02.mdl",
	"models/Humans/Group01/male_08.mdl"
} 
bbc.allowedJobs = { -- A list of all the jobs that can use the bar
	TEAM_CITIZEN
}
bbc.payout = 200 --This is the amount that will be paid for each drink made, devided by the emotion. So if there happy they receive the full amount
--But if there not so happy they only receive a fraction of the amount
 
bbc.minCustomerTime = 0.1 --This is the minimum time in minutes a new customer can arrive (if there is a space at the bar)
bbc.maxCustomerTime = 0.4--Thisis the maximum time in minutes a new customer can arrive (if there is a space at the bar)
--Please note a random time will be chosen between the two
    
bbc.emotionTimeStep = 0.4 --The time in minutes it takes before the people go down one emotion step (There is 4 in total, If they get to 0 then they will leave the bar)
 