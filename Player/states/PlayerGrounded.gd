class_name PlayerGrounded
extends PlayerState


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
		if Input.is_action_just_pressed("shoot"):
			player.animated_sprite.play("shoot_walk")
		else:
			player.animated_sprite.play("walk")
	else:
		if Input.is_action_just_pressed("shoot"):
			player.animated_sprite.play("shoot_stand")
		else:
			player.animated_sprite.play("idle")

