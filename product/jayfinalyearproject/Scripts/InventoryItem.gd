extends TextureButton
class_name InventoryItem

var type = null
var count = 0;
var durability = 1;
var durabilityHold = durability;

@onready var invHold = $"../../../../../InventoryHold"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(wasClicked)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func setType(newType):
	type = newType
	setTexture(str("res://AssetImages/InventoryItems/", type, "Inventory.png"))

	
func setTexture(newTexture):
	self.texture_normal = load(newTexture)
	
func getObjectType():
	return "InventoryItem"
	
func getType():
	return type
	
func getDurability():
	return durability
	
func getCurrentDurability():
	return durability
	
func decreaseDurability():
	durability -=1;
	
func setCount(newCount):
	count = newCount
	
func setDurability(newDurability):
	durability = newDurability
	durabilityHold = durability
	
func increaseCount():
	count += 1
	$Quantity.text = "X"+ str(count)
	
func decreaseCount():
	count -= 1
	$Quantity.text = "X"+ str(count)
	if count == 0:
		invHold.getInventory().removeFromInventory(type)
	
func getCount():
	return count
	
		
func wasClicked():
	if invHold.checkLooking():
		invHold.OpenClose("Inventory")
		invHold.receiveItem(self)
	
	
	
	
