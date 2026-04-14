extends Node2D
#controls the pause screen and all buttons on it
var pauseHold = false
@onready var ResumeButton = $"MainMenuScreen/Control/ResumeButton"
@onready var QuitButton = $"MainMenuScreen/Control/QuitButton"
@onready var ControlsButton = $"MainMenuScreen/Control/ControlsButton"
@onready var BackButton = $"ControlScreen/Control/backButton"

@onready var menuScreen = $"MainMenuScreen"
@onready var controlScreen = $"ControlScreen"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResumeButton.pressed.connect(resumeScene)
	QuitButton.pressed.connect(quitGame)
	ControlsButton.pressed.connect(controlMenu)
	BackButton.pressed.connect(backToMenu)

	pass # Replace with function body.

func resumeScene():
	get_tree().paused = false
	if pauseHold:
		pauseHold = false
		#This resumes the game
		get_tree().paused = false
	else:
		#This stops the game from running
		pauseHold = true
		get_tree().paused = true
	self.visible = pauseHold
	
func quitGame():
	get_tree().quit()
	
func controlMenu():
	menuScreen.visible = false
	controlScreen.visible = true
	
func backToMenu():
	menuScreen.visible = true
	controlScreen.visible = false
	
	

func _process(delta: float) -> void:
	#When esc hit, pauses game
	if Input.is_action_just_pressed("pause"):
		resumeScene()
	
	pass
	
