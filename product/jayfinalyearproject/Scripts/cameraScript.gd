extends Camera3D

func _ready() -> void:
	#culls hidden objects =
	get_tree().root.use_occlusion_culling = true


	
