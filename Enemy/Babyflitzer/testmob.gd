class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite

# Movement of Enemy
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func save():
	var data = {
		"filename":			get_scene_file_path(),
		"parent":			get_path_to(get_parent()),
		"position_x":		self.position.x,
		"position_y":		self.position.y,
		"current_state":	$"State Machine".current_state_name,
	}
	# looking direction, state (welche variablen darin?), health, maxhealth
	return data
