extends Node2D

var pauseHold = false
@onready var ResumeButton = $"MainMenuScreen/Control/ResumeButton"
@onready var QuitButton = $"MainMenuScreen/Control/QuitButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResumeButton.pressed.connect(resumeScene)
	QuitButton.pressed.connect(quitGame)
	pass # Replace with function body.

func resumeScene():
	get_tree().paused = false
	if pauseHold:
		pauseHold = false
		get_tree().paused = false
	else:
		pauseHold = true
		get_tree().paused = true
	self.visible = pauseHold
	
func quitGame():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#When esc hit, pauses game
	if Input.is_action_just_pressed("pause"):
		resumeScene()
	
	pass
	
