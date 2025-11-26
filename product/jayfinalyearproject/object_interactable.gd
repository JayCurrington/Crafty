extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _body_entered(body: Node):
	print("bodyHERE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
