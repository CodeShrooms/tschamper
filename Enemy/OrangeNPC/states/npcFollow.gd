class_name npcIsTalking
extends npcState

@export var animated_sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	animated_sprite.play("talking")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func exit():
	super.exit()
	# start boss fight against npcOrange here
