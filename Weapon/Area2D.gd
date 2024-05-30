class_name Weapon
extends Area2D

var speed = 750
@export var damage = 10

func _ready():
	self.monitoring = true
	self.connect("area_shape_entered", Callable(self, "_on_area_shape_entered"))

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is Enemy:
		area.take_damage(damage)
		queue_free()  # Waffe verschwindet nach dem Treffer (optional)

func _on_body_entered(body):
	queue_free()
