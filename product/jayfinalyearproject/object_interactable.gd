extends Area3D

#This can later be changed to point to a type object.
var type = "Grass"
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_body_entered(body: Node):
	if body.is_in_group("Player") and self.visible:
		body.objectHit(self)
		if player == null:
			player = body
		setImage()

func _on_body_exited(body: Node):
	print("here")
	if body.is_in_group("Player"):
		print(body)
		body.objectGone(self)
		
		
func isPickedUp():
	self.visible = false
	if player != null:
		player.objectGone(self)
	
func getType():
	return self.type

func setImage():
	var texture = load('res://AssetImages/InventoryItems/'+type+'Inventory.png')
	$Sprite3D.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
