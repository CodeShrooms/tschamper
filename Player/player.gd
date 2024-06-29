class_name Player
extends CharacterBody2D

var current_jump_count : int = 0

#variable for current and max life
@export var max_life : int = 100
@onready var current_life: int = max_life
#signal for other nodes
signal update_lives(lives, max_lives)

@export var damage : int = 10
@export var respawn_marker : Marker2D 

# Onreadys
@onready var animated_sprite : AnimatedSprite2D = %AnimatedSprite

var direction : Vector2 = Vector2.ZERO


func _physics_process(_delta):
	# the State Machine alters direction and velocity, updates animation
	# implicit return made explicit
	var _body_collided = move_and_slide()


# Functions that deal with the player dying

func _unhandled_key_input(event):
	if event.is_action_pressed("save_position"):
		respawn_marker.position = self.position
		

	
#TODO what to do when the player dies
func die():
	respawn()

func respawn():
	self.position = respawn_marker.position
	current_life = max_life


# function to take damage / update the current life based on damage
func take_damage(hit_damage: int):
	if current_life > 0:
		current_life = current_life - hit_damage
		# send a signal so other nodes can react to it
		update_lives.emit(current_life, max_life)
		# if taken to much damage the die function is called
	if current_life <= 0:
		die()

# Weiterleitung eines Befehls in die Player StateMachine
func force_state(state_name):
	$StateMachine.force_state(state_name)
