extends Node2D
class_name InventoryHolder

var waitingForItem = false
var waitingPlayer

	
func getInventory():
	var inventory :Inventory = $Control/Container/Inventory
	return(inventory)

#Controls what inventory screen shows when I or C is pressed.
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
		
# Controls the player giving an item to the NPC
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
	
	
