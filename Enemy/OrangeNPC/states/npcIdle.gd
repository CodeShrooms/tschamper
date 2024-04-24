class_name npcIdle
extends npcState

@export var animated_sprite : AnimatedSprite2D
@export var hintPressE : TextureRect

var npc_in_range = false

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	animated_sprite.play("idle")

func _process(_delta):
	if npc_in_range:
		if Input.is_action_just_pressed("interact"):
			player.force_state("PlayerTalking")
			Transitioned.emit(self, "npcIsTalking") # another State if we talk to npc



func _on_npc_chat_detection_body_entered(body):
	if body.name == "Player":
		hintPressE.visible = true
		npc_in_range = true

func _on_npc_chat_detection_body_exited(body):
	if body.name == "Player":
		hintPressE.visible = false
		npc_in_range = false


	
