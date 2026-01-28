extends TextureButton

var type = null;
var count = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture_normal = load("res://AssetImages/InventoryItems/"+type+"Inventory.png")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setType(newType):
	type = newType
func getType():
	return type
	
func setCount(newCount):
	count = newCount
	
func increaseCount():
	count += 1
	
func getCount():
	return count
	
	
	
