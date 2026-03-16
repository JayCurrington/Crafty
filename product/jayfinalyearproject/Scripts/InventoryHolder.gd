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
	
func OpenClose(screen):
	if waitingForItem:
		waitingPlayer.cancelWait()
	if screen == "Inventory":
		getInventory().visible = true
	else:
		getInventory().visible = false
	if self.visible:
		self.visible = false
	else:
		self.visible = true
		
func requestItem(player):
	waitingForItem = true
	self.visible = true
	waitingPlayer = player
func cancelRequest():
	waitingForItem = false
	
func receiveItem(item):
	if(waitingForItem):
		waitingForItem = false
		waitingPlayer.recieveItem(item)
	
func checkLooking():
	return waitingForItem
	
	
