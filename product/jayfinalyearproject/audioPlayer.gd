extends AudioStreamPlayer
#This script is constant through all scenes. Music only stops when game is paused
func _ready():
	stream = load("res://MainTheme.ogg")
	autoplay = true
	play()
	
func _process(delta: float) -> void:
	#if song ends, start again
	if playing == false:
		play()
