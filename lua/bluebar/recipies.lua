//THIS IS NOT A CONFIG, YOU CAN EDIT THESE
//BUT IT IS NOT RECOMMENDED!
 
bb_recipies = {}

function bb_addRecipie(name , items) 

	bb_recipies[name] = items

end

bb_addRecipie("Margarita" , {
	["Lime Juice"] = 3,
	["Triple Sec"] = 1, 
	["Tequila"] = 3
}) 

bb_addRecipie("Mai Tai" , {
	["Dark Rum"] = 2,
	["Orange Curacao"] = 1,
	["Lime Juice"] = 1,
	["Almond Syrup"] = 3 
})

bb_addRecipie("White Russian" , {
	["Fresh Cream"] = 2,
	["Vodka"] = 5, 
})

bb_addRecipie("Bloody Mary" , {
	["Tomato Juice"] = 4,
	["Vodka"] = 3,
})

bb_addRecipie("Screwdriver" , {
	["Orange Juice"] = 4,
	["Vodka"] = 3,
})

bb_addRecipie("Whisky Sour" , {
	["Bourbon"] = 4,
	["Lime Juice"] = 3,
})

bb_addRecipie("Old Fashioned" , {
	["Bourbon"] = 6,
	["Soda"] = 1,
})

bb_addRecipie("Manhattan" , {
	["Italian Vermouth"] = 2,
	["Bourbon"] = 5,
})

bb_addRecipie("Martini" , {
	["French Vermouth"] = 2,
	["Gin"] = 5,
})

bb_addRecipie("Daiquiri" , {
	["Lime Juice"] = 3,
	["White Rum"] = 4,
})

bb_addRecipie("Cosmopolitan" , {
	["Lime Juice"] = 1,
	["Grapefruit Juice"] = 1,
	["Cranberry Juice"] = 1,
	["Cointreau"] = 1,
	["Vodka"] = 3
})

bb_addRecipie("Singapore Sling" , {
	["Soda"] = 4,
	["Brandy"] = 1,
	["Lemon Juice"] = 1,
	["Gin"] = 1,
})

bb_addRecipie("Mojito" , {
	["Lime Juice"] = 2,
	["White Rum"] = 5,
})

bb_addRecipie("Tom Collins" , {
	["Soda"] = 4,
	["Gin"] = 2,
	["Lemon Juice"] = 1,
})

bb_addRecipie("Pina Colada" , {
	["Pineapple Juice"] = 4,
	["White Rum"] = 1,
	["Fresh Cream"] = 2,
})

bb_addRecipie("Sea Breeze" , {
	["Grapefuit Juice"] = 3,
	["Cranberry Juice"] = 3,
	["Vodka"] = 1,
})

bb_addRecipie("Cuba Libre" , {
	["Cola"] = 4,
	["Lime Juice"] = 1,
	["White Rum"] = 2,
})

--[[
bb_addRecipie("Is" , {
	["Lime Juice"] = 2,
	["Cola"] = 1,
	["Fresh Cream"] = 1,
	["Coconut Cream"] = 2,
	["Lemon Juice"] = 1
})

bb_addRecipie("A" , {
	["Lime Juice"] = 5,
	["Cola"] = 3,
	["Fresh Cream"] = 2,
	["Coconut Cream"] = 2,
	["Lemon Juice"] = 22
})

bb_addRecipie("Faggot" , {
	["Lime Juice"] = 5,
	["Cola"] = 3,
	["Fresh Cream"] = 2,
	["Coconut Cream"] = 2,
	["Lemon Juice"] = 22
})]]--