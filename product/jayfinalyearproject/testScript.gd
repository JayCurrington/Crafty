extends Node3D
@onready var inventoryHold = $"InventoryHold"
@onready var inventory = $"InventoryHold/Control/Container/Inventory"
@onready var player = $"Player"
@onready var crafting = $"InventoryHold/Control/Container/Crafting"


func _ready():
	populateInv()
	
	#Run tests
	print ("Test 1: add to inventory: ",  test1())
	print ("Test 2: recipes are populating: ", test2())
	print ("Test 3: can craft a recipe w/ ingredients: ", test3())
	print ("Test 4: can't craft a recipe w/o ingredients: ", test4())
	
	
func populateInv():
	for i in range(5):
		inventory.addToInventory("Grass", 1)
		inventory.addToInventory("Rock", 1)
		inventory.addToInventory("Wood", 1)
		
	inventory.addToInventory("Maraca", 1)
	inventory.addToInventory("Bowl", 1)
	
func test1():
	var temp = len(crafting.getRecipes())
	inventory.addToInventory("Rock", 1)
	return !(len(crafting.getRecipes()) == temp)
	
func test2():
	var recipes = crafting.getRecipes()
	if len(recipes) >0:
		return true
	return false
	
func test3():
	var recipes = crafting.getRecipes()
	for i in recipes:
		if i.checkRecipe(inventory.get_children()):
			crafting.selectRecipe(i)
			return crafting.craftRecipe()
			
func test4():
	var recipes = crafting.getRecipes()
	for i in recipes:
		if !i.checkRecipe(inventory.get_children()):
			crafting.selectRecipe(i)
			return !crafting.craftRecipe()
	
	
