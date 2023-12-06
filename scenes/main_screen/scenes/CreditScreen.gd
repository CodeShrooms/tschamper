extends Node2D

# Speed of scrolling.
@export var base_scroll_speed: int = 60
var current_scroll_speed: int = base_scroll_speed
# Factor to increase speed when holding up/down keys.
var speed_up_factor: int = 10
# Is the speed currently increased?
var speed_up : bool = false


var main_menu_file_path :String = "res://scenes/main_screen/scenes/Menu.tscn"
@onready var credits_scroll_container : ScrollContainer = $CenterContainer/ScrollContainer


func _ready():
	# make scrollbar of ScrollContainer invisible
	credits_scroll_container.get_v_scroll_bar().scale.x = 0

func _process(_delta):
		# Adjust scroll speed based on whether speed_up is true or false
	current_scroll_speed = base_scroll_speed if (not speed_up) else (base_scroll_speed * speed_up_factor)

func finish():
	get_tree().change_scene_to_file(main_menu_file_path)
	
func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()
	# event.is_echo() might be triggered when a key is held down, we dont want the echo behaviour.
	if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up")) and !event.is_echo():
		speed_up = true
	if (event.is_action_released("ui_down") || event.is_action_released("ui_up")) and !event.is_echo():
		speed_up = false


func _on_back_pressed():
	finish()
