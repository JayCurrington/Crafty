extends SplitContainer

@onready var recipeHolder = $RecipeHolder

var recipeItem = preload("res://RecipeItem.tscn")


var PATH = "res://JSONs/recipes.json"
var recipeList

func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	recipeList = jsonText["recipes"]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print( recipeList[1].Name)
	pass
	
	
#for when a player gets a new item and recipes are updated
func itemAdded(newItem):
	pass

#For when the last of an item is uesd and recipes need to be removed
func itemremoved(oldItem):
	pass
	
	
