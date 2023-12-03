extends Node2D

const section_time := 2.0
const line_time := 0.6
const base_speed := 100.0
const speed_up_multiplier := 10.0

#TODO change this color according to design choice
const title_color := Color.INDIGO
const title_font_size = 32
# 
var scroll_speed := base_speed
var speed_up := false

@onready var scroll_container = $CenterContainer/ScrollContainer
@onready var scroll_container_text = $CenterContainer/ScrollContainer/RichTextLabel

var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var main_menu_file_path = "res://scenes/main_screen/scenes/Menu.tscn"
var credits_file_path = "res://scenes/main_screen/files/credits.txt"
var credits := []

func finish():
	if not finished:
		finished = true
		get_tree().change_scene_to_file(main_menu_file_path)

func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()
	if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up")) and !event.is_echo():
		speed_up = true
	if (event.is_action_released("ui_down") || event.is_action_released("ui_up")) and !event.is_echo():
		speed_up = false



func _on_back_pressed():
	finish()
