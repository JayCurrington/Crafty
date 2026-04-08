extends AudioStreamPlayer

func _ready():
	stream = load("res://MainTheme.ogg")
	autoplay = true
	play()
	
func _process(delta: float) -> void:
	print("MUSICCC")
