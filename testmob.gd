extends CharacterBody2D


const SPEED = 30.0
var direction = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# bewegung des Gegners
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# changes direction when hitting a wall
	if is_on_wall(): 
		scale.x = -scale.x
		direction = direction * -1 
		
	# changes direction when on a edge
	if (not $RayCast2D.is_colliding() and is_on_floor()):
		scale.x = - scale.x #mirrors mob 
		direction = direction * -1 #mirrors movement direction
	velocity.x = direction * SPEED
	
	# var query = PhysicsRayQueryParameters2D.create(Vector2(0,0), Vector2(50,100))

	move_and_slide()

