class_name Player
extends CharacterBody2D

var current_jump_count : int = 0

#variable for current and max life
@export var max_life : int 
var current_life : int 
#signal for other nodes
signal update_lives(lives, max_lives)

# Onreadys
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite

var direction : Vector2 = Vector2.ZERO
var saved_position : Vector2


func _physics_process(_delta):
	# the State Machine alters direction and velocity, updates animation
	# implicit return made explicit
	var _body_collided = move_and_slide()


# Functions that deal with the player dying

func _unhandled_key_input(event):
	if event.is_action_pressed("save_position"):
		saved_position = self.position
		

	
#TODO maybe später was anderes, wird gerade nicht verwendet
func die():
	respawn()

func respawn():
	self.position = saved_position
	current_life = max_life
	

# function to take damage / update the current life based on damage
func take_damage(damage: int):
	if current_life > 0:
		print("player got hit with " ,damage, " damage")
		current_life = current_life - damage
		# send a signal so other nodes can react to it
		update_lives.emit(current_life, max_life)
		# if taken to much damage the die function is called
	if current_life <= 0:
		print("player has 0 life points")
		respawn()
	
# set life to max_life on stard_up
func _ready():
	current_life = max_life

