class_name Player
extends CharacterBody2D

var current_jump_count : int = 0

@onready var animated_sprite : AnimatedSprite2D = %AnimatedSprite

var direction : Vector2 = Vector2.ZERO
var saved_position : Vector2

func _ready():
	print("player in _ready(): %s" % self)
	print("position of Player in _ready(): %s" % self.position)

func _physics_process(_delta):
	# the State Machine alters direction and velocity, updates animation
	# implicit return made explicit
	var _body_collided = move_and_slide()


# Functions that deal with the player dying

func _unhandled_key_input(event):
	if event.is_action_pressed("save_position"):
		saved_position = self.position
		

# wenn irgendein Objekt aus den Collision Masks die Area betritt, wird der Spieler gelöscht
func _on_area_2d_body_entered(_body):
	#die()
	pass
	
#was passieren soll, wenn der Player "stirbt". wird zurück zu einem gespeicherten Ort gesetzt
func die():
	self.position = saved_position

# Weiterleitung eines Befehls in die Player StateMachine
func force_state(state_name):
	$StateMachine.force_state(state_name)
	
func save():
	return {
		"filename":		get_scene_file_path(),
		"parent":		get_parent().get_path(),
		"position_x":	self.position.x,
		"position_y":	self.position.y,
		"current_state": $StateMachine.current_state_name
	}
