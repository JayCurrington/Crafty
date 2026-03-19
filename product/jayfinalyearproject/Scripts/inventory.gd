extends GridContainer
class_name Inventory

var inventoryItem = preload("res://InventoryItem.tscn")
@onready var recipeMaker = $"../Crafting"
@onready var player = $"../../../../Player"

var waitingForItem = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Removes one at a time or if no more, removes child.
func removeFromInventory(item):
	print("you made it here")
	for c in self.get_children():
		if c.getType() == item:
			print("removing type: ", item)
			if c.getCount()<=1:
				self.remove_child(c)
			else:
				c.decreaseCount()
			return
	

func addToInventory(item):
	var added = false
	for i in self.get_children():
		if item == i.getType():
			i.increaseCount()
			added = true
	if !added:
		#instanciate the item
		var newItem = inventoryItem.instantiate()
		recipeMaker.itemAdded(item)
		#this adds to the inventory container
		self.add_child(newItem)
		#set values
		newItem.setType(item)
		newItem.setCount(1)
	recipeMaker.checkAllRecipes(self.get_children())
	
