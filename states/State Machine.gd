extends Node

@export var initial_state : State

var current_state : State
var current_state_name: String
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state
		current_state_name = initial_state.name.to_lower()

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())	
	if not new_state:
		return	
		
		
	if current_state:
		current_state.exit()
	new_state.enter()
	
	current_state = new_state
	current_state_name = new_state_name.to_lower()

func force_state(state_name):
	current_state.Transitioned.emit(current_state, state_name)
