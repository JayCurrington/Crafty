extends Area3D
class_name NPC

@onready var dialougePanel = $"DialougePanel"
@onready var dialougeTextBox = $"DialougePanel/DialougeTextBox"
@onready var nextButton = $"DialougePanel/DialougeTextBox/nextButton"
@onready var sprite = $"Sprite3D"

var desiredObject
var player
var charName = "None"
var dialouge = []

# -1 means not talking, otherwise that is the stage of dialouge it is on.
var talkingTracker = -1
var charCounter = 0

func _ready() -> void:
	nextButton.pressed.connect(nextDialouge)
	setImage()

func _process(delta: float) -> void:
	if talkingTracker>=0 :
		if charCounter < len( dialouge[talkingTracker]):
			charCounter +=1
		dialougeTextBox.text = dialouge[talkingTracker].substr(0,charCounter)
	pass


func talkToPlayer():
	if talkingTracker < 0:
		dialougePanel.set_tab_title(0,charName)
		dialougePanel.visible = true
		nextDialouge()
	
func stopTalking():
	talkingTracker = -1
	dialougePanel.visible = false
	

func nextDialouge():
	if(talkingTracker+1 < len(dialouge)):
		talkingTracker += 1
		charCounter = 0
	else:
		stopTalking()
	pass
	
func setName(newName):
	charName = newName
	setImage()
	
func setDialouge(newDialouge):
	dialouge = newDialouge

func setLocation(location):
	self.position = location
	
func setImage():
	sprite.texture = load(str("res://AssetImages/MapItems/NPC", charName, ".png"))

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
		
		
