class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite

# Movement of Enemy
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func _on_area_2d_body_entered(body):
	# If the enemy collides with the player, disable spawning
	print("AAAAAAAA")
	if body.name == "Player":
		#deal damage
		body.take_damage(10)
