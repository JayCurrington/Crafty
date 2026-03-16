extends CharacterBody3D

#Speed of player movement and falling
@export var speed = 15
@export var fall_acceleration = 50

@onready var InventoryHold : InventoryHolder = get_node("../InventoryHold")

@onready var InventoryObj : Inventory = InventoryHold.getInventory()

#tracks jumping length 0 means no longer going upwards.
var jumping = 0
# Tracks nearby interactable object
var nearObject = []
#3D Vector used across frames for directed speed
var target_velocity = Vector3.ZERO
#These track the angle of rotation and transform strech for character walking
var walkRot = 1
var walkTrack = 0
var talking = false
var waitingForItem = false

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
		
	#make Player fall to floor or jump
	if not is_on_floor() and jumping == 0: 
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	elif jumping > 0: 
			target_velocity.y = 10
			
	#Set player velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#Actually move the player
	velocity = target_velocity
	move_and_slide()

#	Deal with interaction with object:
	if Input.is_action_pressed("Interact") and len(nearObject) >0:
		for i in nearObject:
			if i.getObjectType() == "InventoryItem":
				InventoryObj.addToInventory(i.getType())
				i.isPickedUp()
				nearObject.erase(i)
				break
				
			elif  i.getObjectType() == "NPC":
				if !talking:
					talking = true
					i.talkToPlayer()
					break
			
		
		
	if Input.is_action_just_pressed("InventoryOpen"):
		InventoryHold.OpenClose("Inventory")
	if Input.is_action_just_pressed("craftingOpen"):
		InventoryHold.OpenClose("Crafting")
	
	
func objectHit(object):
	if object.getObjectType() != "followNPC":
		get_node("interactMenu").visible = true
		nearObject.append(object)
	
func objectGone(object):
	get_node("interactMenu").visible = false
	for i in nearObject:
		if i== object:
			if i.getObjectType() == "NPC":
				talking = false
				waitingForItem = false
				i.stopTalking()
				InventoryHold.cancelRequest()
		nearObject.erase(i)
	
	
#sent by NPC when they want an item from the player
func requestItem():
	waitingForItem = true
	InventoryHold.requestItem(self)
	
func recieveItem(item):
	if waitingForItem:
		waitingForItem = false
		for i in nearObject:
			if i.getType() == "NPC":
				i.recieveItem(item)
		
func cancelWait():
	return
	
func getLocation():
	return self.position
	
