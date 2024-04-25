class_name npcIsTalking
extends NpcState

@export var animated_sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	animated_sprite.play("talking")
	run_dialogue("big_orange_npc")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func exit():
	super.exit()
	# TODO start boss fight against npcOrange here

func run_dialogue(dialogue_name):
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(dialogue_name)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	player.force_state("PlayerGrounded")
	Transitioned.emit(self, "NpcIdle") # another State if we talk to npc
