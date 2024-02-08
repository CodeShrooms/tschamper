class_name EnemyState
extends State

# common Variables

@export_group("Enemy Variables")

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var enemy: CharacterBody2D # needs to be selected on each enemy state node

@export_group("")

var player: CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func exit():
	pass

# if this is overridden in children classes, call super.enter() !
func enter():
	player = get_tree().get_first_node_in_group("player")


func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
