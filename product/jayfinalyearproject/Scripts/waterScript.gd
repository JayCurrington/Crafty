extends Node3D
#when player hits the water, go to starting location
func _on_body_entered(body: Node):
	print("HIT")
	if body.is_in_group("Player"):
		body.sendToStart()
