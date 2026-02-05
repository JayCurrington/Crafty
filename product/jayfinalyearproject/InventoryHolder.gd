extends Node2D
class_name InventoryHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getInventory():
	var inventoryItem :Inventory = $Control/Container/Inventory
	return(inventoryItem)
