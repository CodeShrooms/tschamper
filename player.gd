extends CharacterBody2D

# player movement variables
@export var speed : float = 200.0
#acceleration between 0-1
@export var acceleration : float = 0.5
@export var deacceleration : float = 100
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100

# features
@export var has_double_jump : bool = false

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif has_double_jump && not has_double_jumped:
			velocity.y += double_jump_velocity
			has_double_jumped = true
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "jump", "down")
	if direction:
		
		var calculated_speed = abs(velocity.x) + (speed * acceleration)
		print("calculated_speed:",calculated_speed)
		velocity.x = direction.x * (calculated_speed if calculated_speed < speed else speed)
		print("velocity.x:",velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, deacceleration)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 0:
		animated_sprite.flip_h = false

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")
		
