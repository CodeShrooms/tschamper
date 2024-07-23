extends Marker2D
 

func _process(_delta: float):   
	#Muzzel follows mous direction similar to flashlight
	look_at(get_global_mouse_position())
