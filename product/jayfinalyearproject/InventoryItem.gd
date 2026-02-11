extends TextureButton
class_name InventoryItem

var type = null
var count = 0;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.texture_normal = load("res://AssetImages/InventoryItems/GrassInventory.png")
	print(str("HERE" , type))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func setType(newType):
	type = newType
	setTexture(str("res://AssetImages/InventoryItems/", type, "Inventory.png"))

	
func setTexture(newTexture):
	self.texture_normal = load(newTexture)
	
func getType():
	return type
	
func setCount(newCount):
	count = newCount
	
func increaseCount():
	count += 1
	$Quantity.text = "X"+ str(count)
	
func getCount():
	return count
	
	
	
	
