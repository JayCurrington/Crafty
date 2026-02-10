extends GridContainer
class_name Inventory

var inventoryItem = preload("res://InventoryItem.tscn")

var activeItems = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#$item1.texture_normal = load("res://AssetImages/TempCatImage2.png")
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#This needs edits
func addToInventory(item):
	var added = false
	for i in activeItems:
		if item.getType() == i.getType():
			i.increaseCount()
			#added = true
	if !added:
		var newItem = inventoryItem.instantiate()
		print(newItem)
		print(newItem.getType())
		self.add_child(newItem)
		print(get_tree())
		
		
		print_tree_pretty()
		
		newItem.setType(item.getType())
		newItem.setCount(1)
		newItem.visible = true
		#newItem.global_position = self.global_position
		print("HERE ",self.get_child_count())
		#activeItems.append(newItem)
