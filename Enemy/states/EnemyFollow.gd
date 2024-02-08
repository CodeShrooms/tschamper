class_name EnemyFollow
extends EnemyState

@export var follow_speed: float
@export var follow_start_range: int
@export var follow_max_range: int

@export var animated_sprite : AnimatedSprite2D

func exit():
	# reset velocity
	enemy.velocity.x = Vector2().x
	# reset sprite-flipping 
	animated_sprite.flip_h = false
	
func Physics_Update(delta: float):
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta

	# get the vector that points to the player
	var direction = player.global_position - enemy.global_position
	
	# flip sprite if player passes enemy
	# direction.x is x-direction to player; enemy shoud face player
	animated_sprite.flip_h = (direction.x > 0)
	
	# direction.length: distance from enemy to player
	if direction.length() < follow_start_range:
		# start following Player if they are close to Enemy
		enemy.velocity.x = direction.normalized().x * follow_speed
	
	if direction.length() > follow_max_range: # FIXME: somehow max_range 80 feels MUCH MUCH bigger than start_range 75 
		# distance to Player to long -> "out of range", do not follow anymore
		Transitioned.emit(self, "EnemyIdle")
	
