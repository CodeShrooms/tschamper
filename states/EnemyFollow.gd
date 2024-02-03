extends State
class_name EnemyFollow


@export var enemy: CharacterBody2D
@export var speed: float
var player: CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	player = get_tree().get_first_node_in_group("player")
	
func Physics_Update(delta: float):

	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 25:
		enemy.velocity.x = direction.normalized().x * speed
	else:
		enemy.velocity.x = Vector2().x
			# Add the gravity.
	if not enemy.is_on_floor():
		enemy.velocity.y += gravity * delta
	
	if direction.length() > 50:
		Transitioned.emit(self, "EnemyIdle")
