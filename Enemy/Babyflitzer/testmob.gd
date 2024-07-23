class_name Enemy
extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite
@onready var damage_area : Area2D = $DamageArea
@export var damage : int = 10

# Variable for current and max life
@export var max_life : int = 100
@onready var current_life: int = max_life 
# Signal for other nodes
signal update_lives(lives, max_life)

# For the sprite looking direction: true = left
# Calls the function turn when the variable is set 
var is_looking_left = true: set = turn

func _ready():
	# Verbinde das Signal
	damage_area.connect("area_shape_entered",  Callable(self, "_on_area_shape_entered"))

# Turns the whole node with sprite and box
func turn(new_direction):
	self.scale.x = self.scale.x * -1
	get_node("ProgressBar").scale.x = get_node("ProgressBar").scale.x * -1
	is_looking_left = new_direction

# Movement of Enemy
func _physics_process(_delta):
	var _body_collided = move_and_slide()  # Implicit return made explicit

# Function to take damage / update the current life based on damage
func take_damage(hit_damage: int):
	if current_life > 0:
		current_life -= hit_damage
		# Send a signal so other nodes can react to it
		update_lives.emit(current_life, max_life)
		# If taken too much damage, the die function is called
	if current_life <= 0:
		die()

# Defines what to do when the mob loses all health
func die():
	queue_free()

# Attack
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage)
		take_damage(damage)

# When another area enters the enemy's DamageArea
func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Weapon:
		take_damage(area.damage)
