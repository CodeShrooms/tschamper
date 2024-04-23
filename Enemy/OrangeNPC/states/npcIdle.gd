class_name npcIdle
extends npcState

@export var animated_sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	animated_sprite.play("idle")


func someFunction():
	
	
	Transitioned.emit(self, "npcIsTalking")
