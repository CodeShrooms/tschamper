class_name PlayerGrounded
extends PlayerState

@export var animated_sprite : AnimatedSprite2D

func enter():
	super.enter()

	player.current_jump_count = 0

func Physics_Update(_delta: float):
	# leave this state if player is not on floor
	if not player.is_on_floor():
		Transitioned.emit(self, "PlayerAirborne")

	# handle jump when on floor
	if Input.is_action_just_pressed("jump"):
		if player.current_jump_count < max_jump_count:
			player.velocity.y = jump_velocity

			# only add 1 to jump count if player.velocity.y has been written
			player.current_jump_count += 1

	handle_other_inputs()


	# update direction of sprite
	update_facing_direction()

	# update animation
	if player.direction.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

