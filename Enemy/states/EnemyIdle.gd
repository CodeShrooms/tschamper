class_name EnemyIdle
extends EnemyState

@export var idle_speed: float 
@export var RayCast: RayCast2D


var move_diriction: Vector2
var wander_time: float

var direction: float

func enter():
	super.enter()
	
	direction = -1

func Physics_Update(delta:float):
	# Add the gravity.
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta

	# changes direction when on a edge or when hitting a wall	
	if (not RayCast.is_colliding() and enemy.is_on_floor()) or (enemy.is_on_wall()):
		direction = direction * -1 #mirrors movement direction
		# flip mob sprite
		enemy.scale.x = -enemy.scale.x # direction.x is x-direction to player; enemy shoud face player
	
	enemy.velocity.x = direction * idle_speed

	var distance_to_player = player.global_position - enemy.global_position
	if distance_to_player.length() < 50:
		Transitioned.emit(self, "EnemyFollow")
