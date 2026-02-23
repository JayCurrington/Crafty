extends SplitContainer

@onready var recipeHolder = $RecipeHolder

var recipeItem = preload("res://RecipeItem.tscn")


var PATH = "res://JSONs/recipes.json"
var recipeList
var activeItems = []
var activeRecipes = []

func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	recipeList = jsonText["recipes"]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
#for when a player gets a new item and recipes are updated
func itemAdded(newItem):
	#this may be done twice.. I think this is only called when making new item
	if not activeItems.has(newItem):
		print ("adding item")
		activeItems.append(newItem)
		for i in recipeList:
			if i.Ingredient1 == newItem or i.Ingredient2 == newItem or i.Ingredient3 == newItem:
				var isNew = true
				for j in activeRecipes:
					if j.getName() == i.Name:
						isNew = false
						print("you already have this item.")
						break
				if isNew:
					print("make a new recipe!")
					makeRecipe(i)
				
	pass

#For when the last of an item is uesd and recipes need to be removed
func itemremoved(oldItem):
	pass
	
func makeRecipe(recipeTemplate):
	var newRecipe = recipeItem.instantiate()
	recipeHolder.add_child(newRecipe)
	newRecipe.setComponents(recipeTemplate.Ingredient1, recipeTemplate.Ingredient2, recipeTemplate.Ingredient3)
	
	pass
	
	
