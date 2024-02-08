extends CharacterBody2D


# Movement of Enemy
func _physics_process(delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	move_and_slide()

