extends Node2D

@onready var BackButton = $"CreditsScreen/Control/backButton"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BackButton.pressed.connect(backToMenu)


	
func backToMenu():
		get_tree().change_scene_to_file('res://startMenu.tscn')

	
