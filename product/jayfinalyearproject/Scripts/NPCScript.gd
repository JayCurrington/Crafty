extends Area3D
class_name NPC

@onready var dialougePanel = $"DialougePanel"
@onready var dialougeTextBox = $"DialougePanel/DialougeTextBox"

var desiredObject
var player
var charName = "None"

func _ready() -> void:
	pass


func talkToPlayer():
	dialougePanel.set_tab_title(0,charName)
	
	
func nextDialouge():
	pass
	
func setName(newName):
	charName = newName
	

#checks the item the player gave them is correct
func checkItem(playerItem):
	if playerItem == desiredObject:
		print("Yay! This is what I wanted! Thanks")
	else:
		print("Nope, not sure why you thought I'd want that...")


	
func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.objectHit(self)
		if player == null:
			player = body

func _on_body_exited(body: Node):
	if body.is_in_group("Player"):
		body.objectGone(self)
		
func getObjectType():
	return "NPC"
		
		
