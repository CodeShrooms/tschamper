class_name NPC
extends CharacterBody2D

@export var animated_sprite : AnimatedSprite2D
@export var hintPressE : TextureRect

var npc_in_range = false
var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("player")

# Movement of Entity
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

func _process(_delta):
	if npc_in_range:
		if Input.is_action_just_pressed("interact"):
			animated_sprite.play("talking") # another Animation if we talk to npc
			run_dialogue("big_orange_npc")

func _on_npc_chat_detection_body_entered(body):
	if body.name == "Player":
		hintPressE.visible = true
		npc_in_range = true

func _on_npc_chat_detection_body_exited(body):
	if body.name == "Player":
		hintPressE.visible = false
		npc_in_range = false

func run_dialogue(dialogue_name):
	# stop animation und so
	Dialogic.start(dialogue_name)
	
