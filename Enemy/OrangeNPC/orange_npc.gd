class_name NPC
extends CharacterBody2D

# Movement of Entity
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit
