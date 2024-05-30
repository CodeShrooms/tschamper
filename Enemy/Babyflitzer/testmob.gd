class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite
@export var damage : int = 10

#variable for current and max life
@export var max_life : int  = 100
@onready var current_life: int = max_life 
#signal for other nodes
signal update_lives(lives, max_lives)


#for the sprite looking direction: true = left
# calls the function turn when the variable is set 
var is_looking_left = true: set = turn



#turns the whole node with sprite and box
func turn(new_direction):
	self.scale.x = self.scale.x * -1
	get_node("ProgressBar").scale.x = get_node("ProgressBar").scale.x * -1
	is_looking_left = new_direction



# Movement of Enemy
func _physics_process(_delta):
	# manipulation of direction and velocity as well as gravity is handled in the State Machine
	var _body_collided = move_and_slide() # implicit return made explicit

# function to take damage / update the current life based on damage
func take_damage(hit_damage: int):
	if current_life > 0:
		current_life = current_life - hit_damage
		# send a signal so other nodes can react to it
		update_lives.emit(current_life, max_life)
		# if taken to much damage the die function is called
	if current_life <= 0:
		die()

# defines what to do when the mob loses all health
func die():
	queue_free()

#Attack
func _on_area_2d_body_entered(body):
	# If the enemy collides with the player, both taking damage 
	if body.name == "Player":
		#deal damage
		body.take_damage(damage)
		
	take_damage(damage)
	if body.name == "Weapon":
		take_damage(damage)
	 

