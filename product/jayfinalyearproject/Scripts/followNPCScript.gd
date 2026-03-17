extends Area3D

var type = "followNPC"

var waypointCounter = 0
var waypoints = [Vector3(-10,1,3), Vector3(0,1,3), Vector3(-10,1,13)]
var defaultLocation = Vector3(-10,1,3)
var player
var chasingCounter = 0
var speed = 0.1

func _physics_process(delta: float) -> void:
	var velocity = Vector3(0,0,0)
	
	if player != null and chasingCounter != 0:
		chasingCounter-=1
		velocity = (self.position.direction_to(player.getLocation()))*speed
	elif self.position != defaultLocation:
		if(self.position.distance_to(waypoints[waypointCounter%waypoints.size()])<0.5):
			waypointCounter+=1
		velocity = (self.position.direction_to(waypoints[waypointCounter%waypoints.size()]))*speed
	translate(velocity)
	transform = transform.orthonormalized()
	

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		player = body
		chasingCounter = -1

func _on_body_exited(body: Node):
	chasingCounter = 300
	pass
		

		
func getObjectType():
	return type
