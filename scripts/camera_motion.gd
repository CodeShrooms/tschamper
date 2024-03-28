extends Camera2D

var target_offset = Vector2(0.0, 0.0)
var current_offset = Vector2(0.0, 0.0)

@export var mouse_panning_distance: float = 30.0
@export var acceleration_factor: float = 1.0
@export var mouse_panning_enabled: bool = true

func _input(_event: InputEvent):
	var pos = get_viewport().get_mouse_position()
	var rect = get_viewport().get_visible_rect().size
	
	# convert screen relative coordinates to viewport relative coordinates
    # transforms viewport relative coordinates from [0, view_width] into range [-1, 1]
	target_offset.x = pos.x / rect.x * 2.0 - 1.0
	target_offset.y = pos.y / rect.y * 2.0 - 1.0
	# scale coordinates up
	target_offset *= mouse_panning_distance;

# cubic ease curve for in and out
func cubic_ease_in_out(x: float) -> float:
	var sq = x * x
	return 3.0 * sq - 2.0 * sq * x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if (!mouse_panning_enabled):
		target_offset = Vector2(0, 0)
	
	# compute amount to move this frame
	var delta_offset = (target_offset - current_offset)
	
	# compute maximum linear extrusion factor
	var max_len = sqrt(mouse_panning_distance * mouse_panning_distance * 2.0)
    # normalize extrusion factor by maximum length
	var curve = delta_offset.length() / max_len
    # smooth out camera motion by transforming linear to cubic curve
	curve = clamp(cubic_ease_in_out(curve), 0.0, 1.0)
	
	# ease out animation and correct by delta frame time
	delta_offset *= delta * curve * acceleration_factor
	current_offset += delta_offset
	
	# move camera
	self.offset += delta_offset
