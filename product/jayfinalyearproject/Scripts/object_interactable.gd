extends Area3D

#This can later be changed to point to a type object.
var itemTypes = ["Grass","Rock","Log"]
var type = itemTypes.pick_random()
var player = null
var regenTime = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	#set image to correct item
	setImage()
	pass
	
func _process(delta: float) -> void:
	if regenTime == 0:
		regen()
	elif regenTime>0:
		regenTime-=1
		
func setLocation(location):
	self.position = location
	
func regen():
	regenTime = -1
	self.visible = true
	
func _on_body_entered(body: Node):
	if body.is_in_group("Player") and self.visible:
		body.objectHit(self)
		if player == null:
			player = body

func _on_body_exited(body: Node):
	if body.is_in_group("Player"):
		body.objectGone(self)
		
func getObjectType():
	return "InventoryItem"
		
		
func isPickedUp():
	self.visible = false
	regenTime = 1000
	if player != null:
		player.objectGone(self)
	
func getType():
	return self.type

func setImage():
	var texture = load(str("res://AssetImages/MapItems/", type, "Map.png"))
	$Sprite3D.texture = texture
