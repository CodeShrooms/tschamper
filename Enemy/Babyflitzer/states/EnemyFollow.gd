class_name EnemyFollow
extends EnemyState

@export var follow_speed: float

@export var animated_sprite : AnimatedSprite2D
var is_sprite_flipped_initially: bool


func enter():
	super.enter()
	is_sprite_flipped_initially = animated_sprite.flip_h

func exit():
	super.exit()
	
	# reset velocity
	enemy.velocity.x = 0.0
	# reset sprite-flipping 
	animated_sprite.flip_h = is_sprite_flipped_initially

func Physics_Update(delta: float):
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta

	# get the vector that points to the player
	var direction = player.global_position - enemy.global_position
	
	# flip sprite if player passes enemy
	# direction.x is x-distance to player; enemy should face player
	
	
	
	if enemy.is_looking_left != (direction.x < 0):
		enemy.is_looking_left = not enemy.is_looking_left
		
	
	
	# direction.length: distance from enemy to player
	if direction.length() < follow_start_range:
		# start following Player if they are close to Enemy
		# 'direction.normalized().x' normalizes the direction (distance vector to the player, normalized to length 1); is used to flip the horizontal movement and it makes the enemy slightly faster when getting near the player
		# 'direction': left = negative velocity (direction = -1); right = positive velocity (direction = 1)
		# this calculation does not involve acceleration, therefore it does not need to involve the 'delta' parameter (time between frames) 
		if direction.normalized().x < 0: # 'left'
			enemy.velocity.x = -1 * follow_speed
		else: # 'right'
			enemy.velocity.x = follow_speed
	
	if direction.length() > follow_max_range: 
		# distance to Player to long -> "out of range", do not follow anymore
		Transitioned.emit(self, "EnemyIdle")
	
