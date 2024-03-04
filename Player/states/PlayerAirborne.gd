class_name PlayerAirborne
extends PlayerState

@export var animated_sprite : AnimatedSprite2D

func Physics_Update(delta: float):
	# leave this state if player is on floor
	if player.is_on_floor():
		Transitioned.emit(self, "PlayerGrounded")

	# Add the gravity.
	player.velocity.y += gravity * delta

	# Handle jump when airborne
	if Input.is_action_just_pressed("jump"):
			if player.current_jump_count < max_jump_count:
				if allow_extra_jumps_without_first_jump_from_floor or player.current_jump_count >= 1:
					if player.velocity.y > 0:
						# y gets bigger when further down
						player.velocity.y = extra_jump_velocity
					else:
						player.velocity.y += extra_jump_velocity

					# only add 1 to jump count if player.velocity.y has been written
					player.current_jump_count += 1

	handle_other_inputs()


	# update direction of sprite
	update_facing_direction()

	# update animation # FIXME: walking in the air?!
	if player.direction.x != 0:
		player.animated_sprite.play("walk")
	else:
		player.animated_sprite.play("idle")




