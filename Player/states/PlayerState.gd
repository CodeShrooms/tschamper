class_name PlayerState
extends State

# variables that need to access nodes below player or runtime variables CANNOT be put here: PlayerState does not really get instantiated!

var player: Player

# Exports
@export_group("Player Movement Variables")
@export var movement_speed : float = 30.0
# default speed is normal movement speed
var speed : float = movement_speed
# dash speed should be min 120x normal speed
@export var dash_speed_multiplier : float = 250.0
# if you make the dash-speed-multiplier higher, usually the duration should be lowered
@export var dash_duration : float = .2
@export var dash_cooldown : float = 2
@export var acceleration : float = 15
@export var deacceleration : float = 20
@export var jump_velocity : float = -125
@export var extra_jump_velocity : float = -80
@export var max_jump_count : int = 1
# allows jumping while falling (to dampen fall) without havin jumped from a floor
@export var allow_extra_jumps_without_first_jump_from_floor : bool = true
# to set a custom gravity, change the value here (or set it in the Inspector via @export, however, ProjectSettings.get_setting doesn't work with @export)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var allow_dash: bool = true
@export var allow_wall_jump: bool = true
@export_group("")

# calculate the dash speed
var dash_speed : float = dash_speed_multiplier * movement_speed 
@onready var dash : Node = %dash

func _ready():
	pass

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
	
	handle_dash_input()
	
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

func handle_dash_input():
	# Check if the player does a dash - for every state a dash is possible
	if allow_dash:
		if Input.is_action_just_pressed("dash") and dash.is_dash_cooldown_over():
			dash.start_dash(dash_duration, dash_cooldown)
		# check if the player is dashing and adjust the player speed accordingly
		speed = dash_speed if dash.is_dashing() else movement_speed
	else:
		# if the dash is disabled while we are dashing, we still need to reset dash speed to default
		speed = movement_speed
	

