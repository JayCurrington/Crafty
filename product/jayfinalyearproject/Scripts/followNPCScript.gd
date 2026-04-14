extends CharacterBody3D

var type = "followNPC"
@onready var player = $"../Player"
@onready var navAgent = $"NavigationAgent3D"

@onready var dialougePanel = $"DialougePanel"
@onready var dialougeTextBox = $"DialougePanel/DialougeTextBox"

#sets waypoints to locations relative of starting location
var waypointCounter = 0
@onready var waypoints = [self.position+ Vector3(-10,0,0), self.position+Vector3(0,0,10),self.position+ Vector3(-10,0,10)]
var defaultLocation = Vector3(-10,1,3)
var speed = 8
var chasingCounter = 1
var gravity = 50
var holdingItem = null
var dialouge =""
var dialougeCounter =0

func _ready() -> void:
	navAgent.max_speed = speed


func _physics_process(delta: float) -> void:
	#if player close, start chasing
	if self.position.distance_to(player.getLocation()) < 5 and holdingItem == null:
		chasingCounter = 150
	#If still close to player or on cooldown, target player
	if chasingCounter > 0:
		navAgent.target_position = player.getLocation()
		chasingCounter-=1
		
		#If hits player
		if self.position.distance_to(player.getLocation()) < 1.26 and holdingItem == null:
			steal()
				
	#otherwise, go to the next waypoint
	else:
		goToWaypoint()
			
	speaking()
	
			
	var next_path_position = navAgent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	velocity = direction * speed
	
	if not is_on_floor(): 
		velocity.y = velocity.y - (gravity * delta)
	
	navAgent.velocity = velocity
	move_and_slide()

func speaking():
	#Say dialouge one character at a time.
	if dialougeCounter < len(dialouge):
		dialougeCounter +=1
		dialougeTextBox.text = dialouge.substr(0,dialougeCounter)
	else:
		dialouge = ""
		dialougePanel.visible = false
		
func goToWaypoint():
	navAgent.target_position = waypoints[waypointCounter%waypoints.size()]
		#If at waypoint, go to the next one
	if(self.position.distance_to(waypoints[waypointCounter%waypoints.size()])<1):
		holdingItem = null
		waypointCounter+=1
	
func steal():
	chasingCounter = -1
	holdingItem = player.stealRandomItem()
#tell the player what it took
	print(holdingItem)
	dialougePanel.set_tab_title(0,"Theif")
	dialougeCounter = 0
	if holdingItem!= null:
		#Don't take the raft
		if holdingItem == "Raft":
			dialouge = "Oh, a raft? I won't take that.          "
		else:
			dialouge = "Ha! I stole your "+ holdingItem+". Hope you didn't need that...          "
	else:
		holdingItem = "None"
		dialouge = "Oh... you don't have anything. That's kind of sad.          "
	dialougePanel.visible = true

		
func getObjectType():
	return type
