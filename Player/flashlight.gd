extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):   
	 
	var mouse = get_viewport().get_mouse_position()	# mouse position in view space
	var rect = get_viewport_rect()					# size of configured viewport
	var view = get_viewport()						# size of actual viewport
	
	# convert absolute viewport to actual viewport coordinates
	var mouse2 = Vector2(
		mouse.x / rect.size.x * view.size.x,
		mouse.y / rect.size.y * view.size.y)
	
	# center of flashlight node in view space
	var center = get_viewport_transform() * (get_global_transform() * position)
	# vector between mouse and flashlight center
	var dist = mouse2 - center;

	# transform vector between flashlight and mouse into polar angle
	# and apply rotation
	self.rotation = atan2(dist.y, dist.x) - PI * 0.5
	
	pass
