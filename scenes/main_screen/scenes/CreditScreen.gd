extends Node2D

var main_menu_file_path :String = "res://scenes/main_screen/scenes/Menu.tscn"

func _on_back_pressed():
	finish()

func finish():
	get_tree().change_scene_to_file(main_menu_file_path)
