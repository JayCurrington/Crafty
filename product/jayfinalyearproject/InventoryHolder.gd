extends Node2D
class_name InventoryHolder

var inventoryItem = preload("res://InventoryItem.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getInventory():
	var inventory :Inventory = $Control/Container/Inventory
	return(inventory)
	
func addToInventory(item):
	var newItem = inventoryItem.instantiate()
	print(newItem)
	print(newItem.getType())
	getInventory().add_child(newItem)
	newItem.owner = get_tree().get_root()
	newItem.setType(item.getType())
	newItem.setCount(1)
	newItem.visible = true
	#newItem.global_position = self.global_position
	print("HERE ",getInventory().get_child_count())
	#activeItems.append(newItem)
	
