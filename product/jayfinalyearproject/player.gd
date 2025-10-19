extends CharacterBody3D

#Speed of player movement and falling
@export var speed = 15
@export var fall_acceleration = 75

#3D Vector used across frames for directed speed
var target_velocity = Vector3.ZERO

#Automatically called by the engine when scene run and is called on fix time ints
func _physics_process(delta):
	print("called.")
	#Stores the direction of the player
	var direction = Vector3.ZERO
	#these not in elif statements as that would mean player can't move diagonally.
	#Move player based on direction on both x and z axes
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		print("moving")
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		print("moving")

#The higher the z, the further into the screen the player goes.
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		print("moving")
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		print("moving")
	
	#If the func is not still, make sure only goes one unit at a time (even diagonally)
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node. - makes player look around?? 
#		$Pivot.basis = Basis.looking_at(direction)
		
	#Set player velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#Add here for fall velocity later on in dev. process.
	
	#Actually move the player
	velocity = target_velocity
	move_and_slide()
		
