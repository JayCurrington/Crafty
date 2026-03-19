extends Node2D

var kudosValue = 0

func addKudos():
	kudosValue+=1
	var temp = Sprite2D.new()
	temp.texture = load(str("res://AssetImages/kudos.png"))
	temp.position = Vector2(70*kudosValue, 70)
	self.add_child(temp)
	
func getKudos():
	return kudosValue
