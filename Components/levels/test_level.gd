extends Node2D

var main_menu_file_path = "res://Components/main_screen/scenes/Menu.tscn"

func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()

func finish():
	get_tree().change_scene_to_file(main_menu_file_path)
