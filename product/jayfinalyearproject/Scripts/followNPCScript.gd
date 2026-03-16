extends Area3D

var type = "followNPC"

var defaultLocation = Vector3(-10,1,3)
var player
var chasingCounter = 0
var speed = 0.08

func _physics_process(delta: float) -> void:
	var velocity = Vector3(0,0,0)
	chasingCounter-=1
	if player != null and chasingCounter > 0:
		velocity = (self.position.direction_to(player.getLocation()))*speed
	translate(velocity)
	transform = transform.orthonormalized()
	

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		player = body
		chasingCounter = 300

func _on_body_exited(body: Node):
	pass
		

		
func getObjectType():
	return type
