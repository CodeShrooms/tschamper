class_name NPC
extends CharacterBody2D

var npc_in_range = false

# Movement of Entity
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func enemy():
	pass

func _process(_delta):
	if npc_in_range:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("big_orange_npc")

func _on_npc_chat_detection_body_entered(body):
	if body.has_method("player"):
		npc_in_range = true

func _on_npc_chat_detection_body_exited(body):
	if body.has_method("player"):
		npc_in_range = false

func run_dialogue(dialogue_name):
	# stop animation und so
	Dialogic.start(dialogue_name)
	
