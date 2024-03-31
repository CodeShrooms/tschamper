extends Node

@onready var timer : Timer = $dash_timer

func start_dash(duration):
	timer.wait_time = duration
	timer.start()
	
func is_dashing():
	return timer.is_stopped()
