class_name Player
extends CharacterBody2D

var current_jump_count : int = 0

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
		

# wenn irgendein Objekt aus den Collision Masks die Area betritt, wird der Spieler gelöscht
func _on_area_2d_body_entered(_body):
	die()
	
#was passieren soll, wenn der Player "stirbt". wird zurück zu einem gespeicherten Ort gesetzt
func die():
	self.position = saved_position