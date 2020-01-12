//THIS IS NOT A CONFIG, YOU CAN EDIT THESE
//BUT IT IS NOT RECOMMENDED!

bb_bottles = {}
bb_bottles.colors = {}
bb_bottles.row1 = {}
bb_bottles.row2 = {}
bb_bottles.row3 = {}

function bb_addBottle(name, row, bottleType , bottleMat , glassMat , color , density)

	local temp = {}
	temp.name = name
	temp.row = row
	temp.bottleType = bottleType
	temp.bottleMat = bottleMat
	temp.glassMat = glassMat

	if row==1 then
		table.insert(bb_bottles.row1 , temp)
	elseif row==2 then
		table.insert(bb_bottles.row2 , temp)
	elseif row==3 then
		table.insert(bb_bottles.row3 , temp)
	end

	bb_bottles.colors[name] = {}
	bb_bottles.colors[name].color = color 
	bb_bottles.colors[name].density = density or 1

end

--Bottled Added Here   

bb_addBottle("Lime Juice" , 1 , 3 , "blues-bar/bottle_3_lime_juice" , "blues-bar/bottle_3_glass" , Color(109 , 164 , 32))
bb_addBottle("Orange Juice" , 1 , 3 , "blues-bar/bottle_3_main" , "blues-bar/bottle_3_glass" , Color(246, 159, 1))
bb_addBottle("Tomato Juice" , 1 , 3 , "blues-bar/bottle_3_tomato_juice" , "blues-bar/bottle_3_glass" , Color(188 , 20 , 4) , 2)
bb_addBottle("Grapefruit Juice" , 1 , 3 , "blues-bar/bottle_grapfruit_juice" , "blues-bar/bottle_3_glass" , Color(253,107,48) , 2)
bb_addBottle("Cranberry Juice" , 1 , 3 , "blues-bar/bottle_cranberry_juice" , "blues-bar/bottle_2_glass" , Color(90 , 1 ,0) , 2)
bb_addBottle("Lemon Juice" , 1 , 3 , "blues-bar/bottle_lemon_juice" , "blues-bar/bottle_3_glass" , Color(224,250,179))
bb_addBottle("Pinapple Juice" , 1 , 3 , "blues-bar/bottle_pineapple_juice" , "blues-bar/bottle_3_glass" , Color(253,232,78))
bb_addBottle("Cola" , 1 , 3 , "blues-bar/bottle_cola" , "blues-bar/bottle_3_glass" , Color(10,6,5) , 6)
bb_addBottle("Fresh Cream" , 1 , 3 , "blues-bar/bottle_cream" , "blues-bar/bottle_3_glass" , Color(220,220,200))
bb_addBottle("Soda" , 1 , 3 , "blues-bar/bottle_soda" , "blues-bar/bottle_3_glass" , Color(230,240,250))
   
bb_addBottle("Triple Sec" , 2 , 2 , "blues-bar/bottle_triple_sec" , "blues-bar/bottle_3_glass" , Color(250,230,220))
bb_addBottle("Tequila" , 2 , 2 , "blues-bar/bottle_tequila" , "blues-bar/bottle_3_glass" , Color(192,131,0))
bb_addBottle("Curacao" , 2 , 2 , "blues-bar/bottle_curacao" , "blues-bar/bottle_3_glass" , Color(10,69,242) , 4) 
bb_addBottle("Vodka" , 2 , 2 , "blues-bar/bottle_2_main" , "blues-bar/bottle_3_glass" , Color(238,238,238))
bb_addBottle("Bourbon" , 2 , 2 , "blues-bar/bottle_bourbon" , "blues-bar/bottle_2_glass" , Color(169,42,26) , 8)
bb_addBottle("Cointreau" , 2 , 2 , "blues-bar/bottle_cointreau" , "blues-bar/bottle_3_glass" , Color(216,86,9))
bb_addBottle("Gin" , 2 , 2 , "blues-bar/bottle_gin" , "blues-bar/bottle_3_glass" , Color(190,225,217))
      
bb_addBottle("Dark Rum" , 3 , 1 , "blues-bar/bottle_dark_rum" , "blues-bar/bottle_1_glass_diff" , Color(134,40,17) , 6)
bb_addBottle("White Rum" , 3 , 1 , "blues-bar/bottle_white_rum" , "blues-bar/bottle_1_glass_diff" , Color(200,200,200))
bb_addBottle("Kahlua" , 3 , 1 , "blues-bar/bottle_kahlua" , "blues-bar/bottle_1_glass_diff" , Color(77,20,20))
bb_addBottle("Italian Vermouth" , 3 , 1 , "blues-bar/bottle_italian_vermouth" , "blues-bar/bottle_1_glass_diff" , Color(116,106,70))
bb_addBottle("French Vermouth" , 3 , 1 , "blues-bar/bottle_french_vermouth" , "blues-bar/bottle_1_glass_diff" , Color(116,106,70))
bb_addBottle("Brandy" , 3 , 1 , "blues-bar/bottle_brandy" , "blues-bar/bottle_1_glass_diff" , Color(150,45,50) , 8)

