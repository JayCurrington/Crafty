extends Node
class_name NPCMaker
#prototype 
var NPCItem = preload("res://npcCharacter.tscn")

#json file
var PATH = "res://JSONs/dialouge.json"
var charList

#Parses json and holds information in the charList
func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	charList = jsonText["Characters"]
	makeCharacter()
		

#Makes all NPCs based on the data in charList
func makeCharacter():
	for i in charList:
		var newCharacter = NPCItem.instantiate()
		self.add_child(newCharacter)
		newCharacter.setName(i.Name)
		newCharacter.setDesiredObj(i.DesiredItem)
		newCharacter.setDialouge(i.Dialouge1,i.DialougeSuccess, i.DialougeFail)
		newCharacter.setLocation(Vector3(i.Location[0], i.Location[1], i.Location[2]))
	pass
