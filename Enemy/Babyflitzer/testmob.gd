class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite

# Movement of Enemy
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func save():
	var data = {
		"position": self.position,
		"current_state": $"State Machine".current_state_name,
	}
	# position, looking direction, state (welche variablen darin?), health, maxhealth
	return data
