extends Control
#Controls the buttons
@onready var MainMenuButton = $"MenuButton"
@onready var CreditsButton = $"CreditsButton"
@onready var QuitButton = $"QuitButton"

func _ready() -> void:
	MainMenuButton.pressed.connect(MainMenuScene)
	QuitButton.pressed.connect(quitGame)
	CreditsButton.pressed.connect(creditScene)

func MainMenuScene():
	get_tree().change_scene_to_file('res://startMenu.tscn')
	
func creditScene():
	get_tree().change_scene_to_file('res://creditsScene.tscn')
	
func quitGame():
	get_tree().quit()
	
