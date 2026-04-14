extends Node2D

#manages buttons on this screen
@onready var BackButton = $"CreditsScreen/Control/backButton"

func _ready() -> void:
	BackButton.pressed.connect(backToMenu)

func backToMenu():
		get_tree().change_scene_to_file('res://startMenu.tscn')

	
