extends CharacterBody3D

#Speed of player movement and falling
@export var speed = 15
@export var fall_acceleration = 75

#tracks jumping length 0 means no longer going upwards.
var jumping = 0

#3D Vector used across frames for directed speed
var target_velocity = Vector3.ZERO

#Automatically called by the engine when scene run and is called on fix time ints
func _physics_process(delta):
	
	#Stores the direction of the player
	var direction = Vector3.ZERO
	
	#these not in elif statements as that would mean player can't move diagonally.
	#Move player based on direction on both x and z axes
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

#The higher the z, the further into the screen the player goes.
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	#If the func is not still, make sure only goes one unit at a time (even diagonally)
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node. - makes player look around?? 
		$Pivot.basis = Basis.looking_at(direction)

	#Jump ability
	if Input.is_action_pressed("jump") and is_on_floor() and jumping == 0:
		jumping = 20
		print("Jump")
	elif jumping > 0:
		jumping -= 1
		print("down Jump")

	#Set player velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#make Player fall to floor or jump 
	if not is_on_floor() and jumping == 0: 
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif jumping > 0: 
		target_velocity.y = 10
	
	#Actually move the player
	velocity = target_velocity
	move_and_slide()
		
