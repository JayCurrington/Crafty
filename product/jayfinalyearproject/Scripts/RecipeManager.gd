extends SplitContainer

@onready var recipeHolder = $RecipeHolder

var recipeItem = preload("res://RecipeItem.tscn")


var PATH = "res://JSONs/recipes.json"
var recipeList
var activeItems = []
var activeRecipes = []
var tempRec = []

func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	recipeList = jsonText["recipes"]
	for i in range(4):
		var temp = recipeItem.instantiate()
		tempRec.append(temp)
		recipeHolder.add_child(temp)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
#for when a player gets a new item and recipes are updated
func itemAdded(newItem):
	#this may be done twice.. I think this is only called when making new item
	# check that the item is not already picked up
	if not activeItems.has(newItem):
		print ("adding item")
		activeItems.append(newItem)
		for i in recipeList:
			# check if recipes contain the item
			if i.Ingredient1 == newItem or i.Ingredient2 == newItem or i.Ingredient3 == newItem:
				var isNew = true
				# check the recipe isnt already active
				for j in activeRecipes:
					if j.getRecipeName() == i.Name:
						isNew = false
						print("you already have this item.")
						break
				# if it is new, make recipe
				if isNew:
					print("make a new recipe!")
					makeRecipe(i)
				
	pass

#For when the last of an item is uesd and recipes need to be removed
func itemremoved(oldItem):
	pass
	
func makeRecipe(recipeTemplate):
	var newRecipe
	if len(tempRec)>0:
		newRecipe = tempRec.get(0)
		tempRec.pop_front()
	else: 
		newRecipe = recipeItem.instantiate()
		recipeHolder.add_child(newRecipe)
	activeRecipes.append(newRecipe)
	print(recipeTemplate.Ingredient1, recipeTemplate.Ingredient2, recipeTemplate.Ingredient3)
	newRecipe.setComponents(recipeTemplate.Ingredient1, recipeTemplate.Ingredient2, recipeTemplate.Ingredient3)
	newRecipe.setName(recipeTemplate.Name)
	pass
	
func checkAllRecipes(inventory):
	for i in activeRecipes:
		if i.checkRecipe(inventory):
			print(i.getRecipeName())
		else:
			print("Can't make this yet")
	

	
	
