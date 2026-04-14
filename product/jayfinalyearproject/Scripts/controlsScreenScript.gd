extends Node2D

#This code controls the function of the button
@onready var ResumeButton = $"ResumeButton"
func _ready() -> void:
	ResumeButton.pressed.connect(resumeScene)


func _process(delta: float) -> void:
	if self.visible:
		get_tree().paused = true
	
func resumeScene():
	self.visible = false
	get_tree().paused = false
	
