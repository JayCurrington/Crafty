extends TextureButton
var recName = "None"
var components = []
var craftable
var description = "There is currently no description"
var durability = 1
@onready var selected = $"SelectionBox"

var showString = "[b]nameTemp[/b]\n descTemp\n \n Components:\n - comp1\n - comp2\n - comp3"

@onready var InventoryObj = $"../../../Inventory"
@onready var DescriptionObj = $"../../Description"
@onready var RecipeMaker = $"../.."

func _ready() -> void:
	imageUpdate()
	self.pressed.connect(wasClicked)

#getters and setters
func getItemNeeded (item):
	return components.count(item)
	
func getRecipeName():
	return recName
	
func setDescription (desc):
	description = desc
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
	
func setDurability(newDurability):
	durability = newDurability

	
func imageUpdate():
	if recName != "None":
		if craftable:
			self.texture_normal = load(str("res://AssetImages/InventoryItems/", recName, "Inventory.png"))
		else:
			self.texture_normal = load(str("res://AssetImages/InventoryItems/Uncraftable/", recName, "InventoryUncraftable.png"))
		
# crafts a recipe if the player has the items to do so
func craftRecipe():
	print(components)
	if(craftable):
		print(true)
		for i in components:
			InventoryObj.removeFromInventory(i)
			print(i)
		InventoryObj.addToInventory(recName, durability)
		return true
	return false
	
#Shows correct description string
func updateString():
	var tempText = showString
	tempText = tempText.replace("nameTemp", recName)
	tempText = tempText.replace("descTemp", description)
	for i in len(components):
		tempText = tempText.replace("comp"+str(i+1), components[i])
	DescriptionObj.text = tempText
	
# checks if the player has the items needed to craft this. If so, recipe changes the image and marked as able to be crafted
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
	
#When clicked, update string, highlight the recipe, and tell manager this is the current selected 
func wasClicked():
	if recName != "None":
		RecipeMaker.selectRecipe(self)
		updateString()
		selected.visible = true

func deselect():
	selected.visible = false

	
	
