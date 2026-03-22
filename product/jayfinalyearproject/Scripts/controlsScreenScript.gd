extends Node2D

@onready var ResumeButton = $"ResumeButton"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ResumeButton.pressed.connect(resumeScene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.visible:
		get_tree().paused = true
	pass
	
func resumeScene():
	self.visible = false
	get_tree().paused = false
	
