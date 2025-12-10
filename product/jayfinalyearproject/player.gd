extends CharacterBody3D

#Speed of player movement and falling
@export var speed = 15
@export var fall_acceleration = 50

#tracks jumping length 0 means no longer going upwards.
var jumping = 0
var nearObject = null

#Inventory, for now, should be structured as an array containing arrays with two elements: 
# [type, quantity]
var inventory = []

#3D Vector used across frames for directed speed
var target_velocity = Vector3.ZERO

#These track the angle of rotation and transform strech for character walking
var walkRot = 1
var walkTrack = 0

#similar to init 
func ready():
	self.contact_monitor = true
	self.max_contacts_reported = 1
	self.connect("body_entered", Callable (self, "_on_body_entered"))
	
func body_entered(body: Node):
	get_node("interactMenu").visible
	print(get_node("interactMenu").visible)



#Automatically called by the engine when scene run and is called on fix time ints - related to gameplay loop
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
		# Setting the basis property will affect the rotation of the node. - makes player look around
		$Pivot.basis = Basis.looking_at(direction)
		
		#Make the chaarcter rotate and bounce when walks
		if(walkTrack >= 5 or walkTrack <= -5 ):
			walkRot = -walkRot
		#print(walkTrack, ", ", walkRot)
		walkTrack += walkRot
		#This sets all size transform to 1, undoes any scaling done ( otherwise shape will be misshapen after while)
		$Pivot.rotate_object_local(Vector3(0, 0, 1), 0.05 * walkRot)
		transform = transform.orthonormalized()
	else:
		$Pivot.rotation.z = 0;

	#Jump ability
	if Input.is_action_pressed("jump") and is_on_floor() and jumping == 0:
		jumping = 20
		#print("Jump")
	elif jumping > 0:
		jumping -= 1
		#print("down Jump")

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

#	Deal with interaction with object:
	if Input.is_action_pressed("Interact") and nearObject != null:
		print("Interact")
		addToInventory(nearObject)
		nearObject.isPickedUp()
		nearObject = null
		
# Adds a passed in item into inventory.
func addToInventory(item):
	var added = false
	for i in inventory:
		if item.getType() == i[0]:
			i[1] += 1
			added = true
	if !added:
		inventory.append([item.getType(), 1])
	
	print (inventory)
	
func objectHit(object):
	get_node("interactMenu").visible = true
	nearObject = object
	print("Hit")
	
func objectGone(object):
	get_node("interactMenu").visible = false
	nearObject = null
	print("gone")
	
func getJumping():
	return (jumping)

	# Collisions:
	
		
