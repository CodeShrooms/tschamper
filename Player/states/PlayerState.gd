class_name PlayerState
extends State

# variables that need to access nodes below player or runtime variables CANNOT be put here: PlayerState does not really get instantiated!

var player: Player

# Exports
@export_group("Player Movement Variables")
@export var speed : float = 200.0
@export var acceleration : float = 10
@export var deacceleration : float = 10

@export var jump_velocity : float = -150.0
@export var extra_jump_velocity : float = -100
@export var max_jump_count : int = 3
# allows jumping while falling (to dampen fall) without havin jumped from a floor
@export var allow_extra_jumps_without_first_jump_from_floor : bool = true
# to set a custom gravity, change the value here (or set it in the Inspector via @export, however, ProjectSettings.get_setting doesn't work with @export)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_group("")

func exit():
	pass

# if this function is overridden, call super.enter() !
func enter():
	player = get_tree().get_first_node_in_group("player")

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

# implement a movement method that is identical for Airborne and Grounded
# FIXME: if another state (e.g. crouching) is added, this function needs to either check for that OR needs to be implemented elsewhere
func handle_other_inputs():
	# Handle other inputs
	# Get the input direction and handle the movement/deceleration.
	player.direction = Input.get_vector("left", "right", "jump", "down") # FIXME: why is here "jump"
	if player.direction:
		# horizontal direction (player (started) pressing button(s))
		player.velocity.x = move_toward(player.velocity.x, player.direction.x * speed, acceleration)
	else:
		# no (longer) horizontal direction (player not (any longer) pressing button(s))
		player.velocity.x = move_toward(player.velocity.x, 0, deacceleration)


func update_facing_direction():
	player.animated_sprite.flip_h = (player.direction.x < 0)
