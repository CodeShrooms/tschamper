class_name Weapon
extends Area2D

#script for the Bullet of a shootingweapon
var speed = 600
@export var damage = 10

func _ready():
	self.monitoring = true
	

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Enemy:
		area.take_damage(damage)
		queue_free() # Bullet dissapers when hit # Ideally, this should happen within the function _on_body_entered(_body), but we will handle it 
					 # here explicitly to ensure the required actions are executed correctly

func _on_body_entered(_body): #activate if not wanted to pass any body 
	queue_free() #prevents bullet form passing through walls , sprits, npcs ... etc
