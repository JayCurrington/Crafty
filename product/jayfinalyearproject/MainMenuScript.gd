extends Control
@onready var StartButton = $"StartButton"
@onready var CreditsButton = $"CreditsButton"
@onready var QuitButton = $"QuitButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartButton.pressed.connect(startScene)
	QuitButton.pressed.connect(quitGame)
	pass # Replace with function body.

func startScene():
	get_tree().change_scene_to_file('res://main.tscn')
	
func creditScene():
	get_tree().change_scene_to_file('res://main.tscn')
	
func quitGame():
	get_tree().quit()
	
