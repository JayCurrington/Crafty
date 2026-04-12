extends Control
@onready var MainMenuButton = $"MenuButton"
@onready var CreditsButton = $"CreditsButton"
@onready var QuitButton = $"QuitButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainMenuButton.pressed.connect(MainMenuScene)
	QuitButton.pressed.connect(quitGame)
	CreditsButton.pressed.connect(creditScene)
	pass # Replace with function body.

func MainMenuScene():
	get_tree().change_scene_to_file('res://startMenu.tscn')
	
func creditScene():
	get_tree().change_scene_to_file('res://creditsScene.tscn')
	
func quitGame():
	get_tree().quit()
	
