extends Marker2D


func _process(_delta: float):   
	look_at(get_global_mouse_position())
