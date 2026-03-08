extends Node
class_name NPCMaker

var NPCItem = preload("res://npcCharacter.tscn")


var PATH = "res://JSONs/dialouge.json"
var charList

func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	charList = jsonText["Characters"]
	makeCharacter()
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func makeCharacter():
	for i in charList:
		print("Hello")
		var newCharacter = NPCItem.instantiate()
		self.add_child(newCharacter)
		newCharacter.setName(i.Name)
		newCharacter.setDialouge(i.Dialouge1)
		newCharacter.setLocation(Vector3(i.Location[0], i.Location[1], i.Location[2]))
	pass
