extends TextureButton
var recName = "None"
var components = []
var craftable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	imageUpdate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getItemNeeded (item):
	return components.count(item)
	
func getRecipeName():
	return recName
	
func setDescription (desc):
	#This will return a formatted string to explain what is needed to craft this item.
	pass

func setComponents(comp1, comp2, comp3):
	components = [comp1, comp2, comp3]

func setName(newName):
	recName = newName
	imageUpdate()
	print(recName)
	
func imageUpdate():
	if recName != "None":
		if craftable:
			self.texture_normal = load(str("res://AssetImages/InventoryItems/", recName, "Inventory.png"))
		else:
			self.texture_normal = load(str("res://AssetImages/InventoryItems/", recName, "InventoryUncraftable.png"))
		
# crafts a recipe if the player has the items to do so
func craftRecipe():
	pass
	
	
func checkRecipe(inventory):
	var componentChecks = components
	for i in inventory:
		for j in componentChecks:
			if i.getType() == j:
				componentChecks.erase(j)
				break
				
	if len(componentChecks) == 0:
		craftable = true
		imageUpdate()
		return true
	craftable = false
	return false
