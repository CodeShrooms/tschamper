class_name PlayerAirborne
extends PlayerState

@export var wall_jump_pushback = 100
@export var wall_jump_boost = -150

func Physics_Update(delta: float):
	# leave this state if player is on floor
	if player.is_on_floor():
		Transitioned.emit(self, "PlayerGrounded")

	# Add the gravity.
	player.velocity.y += gravity * delta

	# Handle jump when airborne
	if Input.is_action_just_pressed("jump"):
		# Do a wall jump, if the player is on the wall (and not colliding with something else) AND pressing the Inputs to move into the wall
		if player.is_on_wall_only():
			# Do a normal jump (set y-Velocity) and move away from wall
			if Input.is_action_pressed("left"):
				player.velocity.y = wall_jump_boost
				player.velocity.x = wall_jump_pushback # positive pushback -> to the right
			elif Input.is_action_pressed("right"):
				player.velocity.y = wall_jump_boost
				player.velocity.x = -wall_jump_pushback # negative pushback -> to the left
		
		# Do a normal jump if there are jumps left
		elif player.current_jump_count < max_jump_count:
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




