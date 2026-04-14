extends Area3D
class_name NPC

@onready var dialougePanel = $"DialougePanel"
@onready var dialougeTextBox = $"DialougePanel/DialougeTextBox"
@onready var nextButton = $"DialougePanel/DialougeTextBox/nextButton"
@onready var sprite = $"Sprite3D"
@onready var kudos = $"../../Kudos"

var desiredObject
var player
var charName = "None"
var dialouge = []
var successDialouge = []
var failDialouge = []

var baseDialouge = []

# -1 means not talking, otherwise that is the stage of dialouge it is on.
var talkingTracker = -1
var charCounter = 0

var endGame = false

func _ready() -> void:
	nextButton.pressed.connect(nextDialouge)
	

func _process(delta: float) -> void:
	#If NPC talking, show one letter per frame until whole text showing (for visulal effect)
	if talkingTracker>=0 :
		if charCounter < len( dialouge[talkingTracker]):
			charCounter +=1
		dialougeTextBox.text = dialouge[talkingTracker].substr(0,charCounter)
	if Input.is_action_just_pressed("nextDialouge") and $DialougePanel/DialougeTextBox/nextButton.visible:
		nextDialouge()

#When player interacts, what dialouge to say.
func talkToPlayer():
	if talkingTracker < 0:
		if desiredObject == "Satisfied":
			dialouge = ["you've already helped me.", "Thanks!"]
		else:
			dialouge = baseDialouge
		dialougePanel.set_tab_title(0,charName)
		dialougePanel.visible = true
		nextDialouge()
	
#set that NPC is not talking and hide the panel
func stopTalking():
	talkingTracker = -1
	dialougePanel.visible = false
	$DialougePanel/DialougeTextBox/nextButton.visible = true
	if endGame:
		get_tree().change_scene_to_file('res://endGame.tscn')
	player.closeInventory()
	
#Sets that the next dialouge shows, if end of dialouge, ends interaction
func nextDialouge():
	if dialougePanel.visible:
		if(talkingTracker+1 < len(dialouge)):
			if talkingTracker >0 and dialouge[talkingTracker+1] == "Do you have what I want?":
				print("HERE " + dialouge[talkingTracker+1])
				requestItem()
			talkingTracker += 1
			charCounter = 0
		else:
			stopTalking()
	pass
	
#setters
func setName(newName):
	charName = newName
	setImage()
	
func setDialouge(newDialouge, newSuccess, newFail):
	baseDialouge = newDialouge
	successDialouge = newSuccess
	failDialouge = newFail
	
func setDesiredObj(newObj):
	desiredObject = newObj

func setLocation(location):
	self.position = location
	
func setImage():
	sprite.texture = load(str("res://AssetImages/MapItems/NPC", charName, ".png"))

#checks the item the player gave them is correct
func checkItem(playerItem):
	$DialougePanel/DialougeTextBox/nextButton.visible = true
	if playerItem == desiredObject:
		dialouge+= successDialouge
		talkingTracker += 1
		if desiredObject == "Raft":
			endGame = true
		else:
			#Mark they have been helped
			kudos.addKudos()
			desiredObject = "Satisfied"
			#If player has helped all NPCs
			if(kudos.getKudos() == 6):
				dialouge+=["You've helped all of us. You should be able to leave now.", "Take this raft we made!"]
		return true
	else:
		dialouge+= failDialouge
		talkingTracker += 1
		return false

#Requests an item from the player
func requestItem():
	$DialougePanel/DialougeTextBox/nextButton.visible = false
	player.requestItem()
	
func recieveItem(item):
	if checkItem(item.getType()):
		item.decreaseCount()
	
#When player enters NPC hitbox
func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.objectHit(self)
		if player == null:
			player = body

func _on_body_exited(body: Node):
	if body.is_in_group("Player"):
		body.objectGone(self)
		stopTalking()
		
func getObjectType():
	return "NPC"
		
		
