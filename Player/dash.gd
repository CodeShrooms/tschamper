extends Node

# % is a specific unique identifier for the variable
@onready var timer : Timer = %dash_timer

# start dashing can be called upon a specific button press for example
func start_dash(duration):
	timer.wait_time = duration
	timer.start()

# to change the speed of the player accordingly, we need to know when the dash is running/over
func is_dashing():
	return !timer.is_stopped()
