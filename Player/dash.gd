extends Node

# timer nodes
@onready var dash_duration_timer : Timer = %dash_duration_timer
@onready var dash_cooldown_timer : Timer = %dash_cooldown_timer

# start dashing can be called upon a specific button press for example
func start_dash(duration, cooldown):
	dash_duration_timer.wait_time = duration
	dash_cooldown_timer.wait_time = cooldown
	dash_duration_timer.start()
	dash_cooldown_timer.start()

# to change the speed of the player accordingly, we need to know when the dash is running/over
func is_dashing():
	return !dash_duration_timer.is_stopped()

# cooldown so you cant spam dash
func is_dash_cooldown_over():
	return dash_cooldown_timer.is_stopped()
