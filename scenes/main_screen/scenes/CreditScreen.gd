extends Node2D

var main_menu_file_path :String = "res://scenes/main_screen/scenes/Menu.tscn"
@onready var credits_scroll_container : ScrollContainer = $CenterContainer/ScrollContainer

func _on_back_pressed():
	finish()

func finish():
	get_tree().change_scene_to_file(main_menu_file_path)

func _ready():
	# make scrollbar of ScrollContainer invisible
	credits_scroll_container.get_v_scroll_bar().scale.x = 0
