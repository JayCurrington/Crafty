extends GridContainer

var InventoryItem = load("res://InventoryItem.tscn")

var activeItems = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
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
			added = true
	if !added:
		var newItem = InventoryItem.instantiate()
		newItem._setType(item.getType())
		newItem.setCount(1)
		activeItems.append(newItem)
