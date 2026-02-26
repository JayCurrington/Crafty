extends TextureButton
var recName = "None"
var components = []
var craftable
var description = "There is currently no description"

var showString = "[b]nameTemp[/b]\n descTemp\n \n Components:\n - comp1\n - comp2\n - comp3"

@onready var InventoryObj = $"../../../Inventory"
@onready var DescriptionObj = $"../../Description"
@onready var RecipeMaker = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	imageUpdate()
	self.pressed.connect(wasClicked)
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
	#allows shorter recipes
	for i in components:
		if i == "None":
			components.erase(i)
	if(len(components)<3):
		showString = showString.substr(0,42+(len(components)*9))


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
	print(components)
	if(craftable):
		print(true)
		for i in components:
			InventoryObj.removeFromInventory(i)
			print(i)
		InventoryObj.addToInventory(recName)
	print("CLICKED")
	pass
	
func updateString():
	var tempText = showString
	tempText = tempText.replace("nameTemp", recName)
	tempText = tempText.replace("descTemp", description)
	for i in len(components):
		tempText = tempText.replace("comp"+str(i+1), components[i])
	DescriptionObj.text = tempText
	
func checkRecipe(inventory):
	var componentChecks = components.duplicate()
	print(components)
	craftable = false
	for i in inventory:
		for k in i.getCount():
			for j in componentChecks:
				if i.getType() == j:
					componentChecks.erase(j)
					print(componentChecks)
					break
				
	if len(componentChecks) == 0:
		craftable = true
		imageUpdate()
		return true
	imageUpdate()
	return false
	
func wasClicked():
	RecipeMaker.selectRecipe(self)
	updateString()

	
	
