extends Node3D

func _on_body_entered(body: Node):
	print("HIT")
	if body.is_in_group("Player"):
		body.sendToStart()
