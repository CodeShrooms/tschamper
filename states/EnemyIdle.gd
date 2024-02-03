extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var SPEED: float 
@export var RayCast: RayCast2D


var move_diriction: Vector2
var wander_time: float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("player")
	
func Update(delta:float):
	pass

func Physics_Update(delta:float):
	# Add the gravity.
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta
	# changes direction when hitting a wall
	if enemy.is_on_wall(): 
		enemy.scale.x = -enemy.scale.x
		direction = direction * -1 
		
	# changes direction when on a edge
	if (not RayCast.is_colliding() and enemy.is_on_floor()):
		enemy.scale.x = - enemy.scale.x #mirrors mob 
		direction = direction * -1 #mirrors movement direction
	enemy.velocity.x = direction * SPEED

	var distance_to_player = player.global_position - enemy.global_position
	
	if distance_to_player.length() < 50:
		Transitioned.emit(self, "EnemyFollow")
