class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite
@export var damage : int = 10

#true = links
var is_looking_left = true: set = turn

#turns the whole node with sprite and box
func turn(new_direction):
	self.scale.x = self.scale.x * -1
	is_looking_left = new_direction
	print(new_direction)


# Movement of Enemy
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func _on_area_2d_body_entered(body):
	# If the enemy collides with the player, disable spawning
	if body.name == "Player":
		print("player entered damage zone")
		#deal damage
		body.take_damage(damage)
