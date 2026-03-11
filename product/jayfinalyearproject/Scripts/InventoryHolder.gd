extends Node2D
class_name InventoryHolder

var inventoryItem = preload("res://InventoryItem.tscn")
var waitingForItem = false
var waitingPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getInventory():
	var inventory :Inventory = $Control/Container/Inventory
	return(inventory)
	
func OpenClose():
	if waitingForItem:
		waitingPlayer.cancelWait()
	if self.visible:
		self.visible = false
	else:
		self.visible = true
		
func requestItem(player):
	waitingForItem = true
	self.visible = true
	waitingPlayer = player
	
func receiveItem(item):
	if(waitingForItem):
		waitingForItem = false
		waitingPlayer.recieveItem(item)
	
func checkLooking():
	return waitingForItem
	
	
