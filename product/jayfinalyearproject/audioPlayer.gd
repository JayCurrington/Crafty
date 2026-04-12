extends AudioStreamPlayer

func _ready():
	stream = load("res://MainTheme.ogg")
	autoplay = true
	play()
	
func _process(delta: float) -> void:
	if playing == false:
		play()
	print("MUSICCC")
