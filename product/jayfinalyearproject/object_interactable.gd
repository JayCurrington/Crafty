extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.objectHit(self)

func _on_body_exited(body: Node):
	print("here")
	if body.is_in_group("Player"):
		print(body)
		body.objectGone(self)
		
func isPickedUp():
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
