extends GridContainer
class_name Inventory

var inventoryItem = preload("res://InventoryItem.tscn")
@onready var recipeMaker = $"../Crafting"
@onready var player = $"../../../../Player"
@onready var kudos = $"../../../../Kudos"

var canLeave = false

var waitingForItem = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if kudos.getKudos() == 1 and !canLeave:
		addToInventory("Raft",1)
		canLeave = true
	pass
	
#Removes one at a time or if no more, removes child.
func removeFromInventory(item):
	for c in self.get_children():
		if c.getType() == item:
			if c.getCurrentDurability() == 1:
				if c.getCount()<=1:
					self.remove_child(c)
				else:
					c.decreaseCount()
				return
			else:
				c.decreaseDurability()
	
#removes a random item from inventory
func removeRandom():
	var allItems = self.get_children()
	var itemType = null
	if len(allItems)>0:
		itemType = allItems[randi()%len(self.get_children())].getType()
		removeFromInventory(itemType)
	return itemType
	

func addToInventory(item, dur):
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
		newItem.setDurability(dur)
	recipeMaker.checkAllRecipes(self.get_children())
	
