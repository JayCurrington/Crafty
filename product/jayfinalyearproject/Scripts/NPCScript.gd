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
	if talkingTracker>=0 :
		if charCounter < len( dialouge[talkingTracker]):
			charCounter +=1
		dialougeTextBox.text = dialouge[talkingTracker].substr(0,charCounter)
	if Input.is_action_just_pressed("nextDialouge") and $DialougePanel/DialougeTextBox/nextButton.visible:
		nextDialouge()


func talkToPlayer():
	if talkingTracker < 0:
		if desiredObject == "Satisfied":
			dialouge = ["you've already helped me.", "Thanks!"]
		else:
			dialouge = baseDialouge
		dialougePanel.set_tab_title(0,charName)
		dialougePanel.visible = true
		nextDialouge()
	
	
func stopTalking():
	talkingTracker = -1
	dialougePanel.visible = false
	$DialougePanel/DialougeTextBox/nextButton.visible = true
	if endGame:
		print("DONE!!!!")
		get_tree().change_scene_to_file('res://endGame.tscn')
	

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
	print(playerItem)
	print(desiredObject)
	$DialougePanel/DialougeTextBox/nextButton.visible = true
	if playerItem == desiredObject:
		dialouge+= successDialouge
		talkingTracker += 1
		if desiredObject == "Raft":
			endGame = true
		else:
			kudos.addKudos()
			desiredObject = "Satisfied"
			if(kudos.getKudos() == 1):
				dialouge+=["You've helped all of us. You should be able to leave now.", "Take this raft we made!"]
		print("Yay! This is what I wanted! Thanks")
		return true
	else:
		dialouge+= failDialouge
		talkingTracker += 1
		print("Nope, not sure why you thought I'd want that...")
		return false


func requestItem():
	$DialougePanel/DialougeTextBox/nextButton.visible = false
	player.requestItem()
	
func recieveItem(item):
	if checkItem(item.getType()):
		item.decreaseCount()
	
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
		
		
