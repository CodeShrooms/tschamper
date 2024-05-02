class_name PlayerTalking
extends PlayerState

@export var animated_sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	player.velocity.x = 0
	animated_sprite.play("talking")

func exit():
	super.exit()
	animated_sprite.play("idle")

func Physics_Update(delta: float):
	if not player.is_on_floor():
		# bring player back to the floor if he was in the air when he started talking to npc
		player.velocity.y += gravity * delta 
	
