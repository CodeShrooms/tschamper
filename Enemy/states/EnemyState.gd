class_name EnemyState
extends State

# variables that need to access nodes below enemy or runtime variables CANNOT be put here: PlayerState does not really get instantiated!

# common Variables

@export_group("Enemy Variables")

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var enemy: Enemy # needs to be selected on each enemy state node

@export_group("")

var player: Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func exit():
	pass

# if this function is overridden, call super.enter() !
func enter():
	player = get_tree().get_first_node_in_group("player")


func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
