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
	# leave this state if player is on floor
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	
