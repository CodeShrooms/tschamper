class_name EnemyIdle
extends EnemyState

@export var SPEED: float 
@export var RayCast: RayCast2D


var move_diriction: Vector2
var wander_time: float

var direction = -1


func Update(delta:float):
	pass

func Physics_Update(delta:float):
	# Add the gravity.
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta
	# changes direction when hitting a wall
	if enemy.is_on_wall(): 
		# flip mob sprite
		enemy.scale.x = -enemy.scale.x
		direction = direction * -1 
		
	# changes direction when on a edge
	if (not RayCast.is_colliding() and enemy.is_on_floor()):
		# flip mob sprite
		enemy.scale.x = - enemy.scale.x
		direction = direction * -1 #mirrors movement direction
	enemy.velocity.x = direction * SPEED

	var distance_to_player = player.global_position - enemy.global_position
	
	if distance_to_player.length() < 50:
		Transitioned.emit(self, "EnemyFollow")
