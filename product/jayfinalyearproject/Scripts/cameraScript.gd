extends Camera3D

var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Automatically called by the engine when scene run and is called on fix time ints
func _physics_process(delta):
	#var isJumping = player.getJumping()
	#if (isJumping > 0):
	#	print("Here")
	pass
	
