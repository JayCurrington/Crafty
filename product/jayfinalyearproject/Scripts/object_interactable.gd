extends Area3D

#Makes every item randomly one of these types
var itemTypes = ["Grass","Rock","Log"]
var type = itemTypes.pick_random()
var player = null
var regenTime = -1

func _ready():
	#set image to correct item
	setImage()
	pass
	
func _process(delta: float) -> void:
	#if time to reappear, regenerate on the map
	if regenTime == 0:
		regen()
	elif regenTime>0:
		regenTime-=1
		
func setLocation(location):
	self.position = location
	
func regen():
	regenTime = -1
	self.visible = true
	
#When player in hitbox
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
		
		
#When picked up, dissapear and remove self from player's near items
func isPickedUp():
	self.visible = false
	regenTime = 1000
	if player != null:
		player.objectGone(self)
	
func getType():
	return self.type

#images are named with the syntax so it is easy to select the correct image witha formatted string
func setImage():
	var texture = load(str("res://AssetImages/MapItems/", type, "Map.png"))
	$Sprite3D.texture = texture
