extends Node
class_name itemMaker

var mapItem = preload("res://ObjectInteractable.tscn")

var PATH = "res://JSONs/itemLocations.json"
var itemList

#parse json with all locations
func _ready():
	var json = JSON.new()
	var file = FileAccess.get_file_as_string(PATH)
	var jsonText = json.parse_string(file)
	itemList = jsonText["ItemLocations"]
	makeItems()
		

#populate map based on locations
func makeItems():
	for i in itemList:
		print("Hello")
		var newItem = mapItem.instantiate()
		self.add_child(newItem)
		var location = Vector3(i.location[0],i.location[1],i.location[2])
			
		newItem.setLocation(location)
		
	pass
