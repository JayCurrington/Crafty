extends GridContainer
class_name Inventory

#prototype button
var inventoryItem = preload("res://InventoryItem.tscn")
@onready var recipeMaker = $"../Crafting"
@onready var player = $"../../../../Player"
@onready var kudos = $"../../../../Kudos"

var canLeave = false

var waitingForItem = false

func _process(delta: float) -> void:
	#if the player has helped all NPCs
	if kudos.getKudos() == 6:
		canLeave = true
		
		for i in self.get_children():
			if i.getType() == "Raft":
				return
		addToInventory("Raft",1)
		
	pass
	
#Removes one at a time when it reaches the last item, it removes the child.
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
	
#removes a random item from inventory -> used by thief NPC
func removeRandom():
	var allItems = self.get_children()
	var itemType = null
	if len(allItems)>0:
		itemType = allItems[randi()%len(self.get_children())].getType()
		removeFromInventory(itemType)
	return itemType
	

#Adds an item to the inventory
func addToInventory(item, dur):
	var added = false
	#If theres an item of this type, increase count 
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
	
