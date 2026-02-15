extends TextureButton
var type = "Grass"
var components = ["Wood","Wood","Rock"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load(str("res://AssetImages/InventoryItems/", type, "Inventory.png"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func itemNeeded (item):
	return components.count(item)
	
func setDescription ():
	#This will return a formatted string to explain what is needed to craft this item.
	pass
