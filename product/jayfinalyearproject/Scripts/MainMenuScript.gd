extends Control
@onready var StartButton = $"StartButton"
@onready var CreditsButton = $"CreditsButton"
@onready var QuitButton = $"QuitButton"

#controls buttons on main menu

func _ready() -> void:
	StartButton.pressed.connect(startScene)
	QuitButton.pressed.connect(quitGame)
	CreditsButton.pressed.connect(creditScene)

func startScene():
	get_tree().change_scene_to_file('res://main.tscn')
	
func creditScene():
	get_tree().change_scene_to_file('res://creditsScene.tscn')
	
func quitGame():
	get_tree().quit()
	
