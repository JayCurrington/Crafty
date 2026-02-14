extends GridContainer
class_name Inventory

var inventoryItem = preload("res://InventoryItem.tscn")
@onready var recipeMaker = $Crasfting

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func addToInventory(item):
	var added = false
	for i in self.get_children():
		if item.getType() == i.getType():
			i.increaseCount()
			added = true
	if !added:
		#instanciate the item
		var newItem = inventoryItem.instantiate()
		recipeMaker.itemAdded(item.getType())
		#this adds to the inventory container
		self.add_child(newItem)
		#set values
		newItem.setType(item.getType())
		newItem.setCount(1)
