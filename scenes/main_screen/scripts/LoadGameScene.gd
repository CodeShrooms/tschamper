extends Control

@onready var mainMenuScreen = %MenuScreen
@onready var currentScreen = $"."

var main_menu_file_path = "res://scenes/main_screen/scenes/Menu.tscn"

func _on_button_pressed():
	print("Button pressed")
	pass # Replace with function body.

func _on_back_pressed():
	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		# Nodes don't exist, return to MainMenu
		finish()

func _on_save_pressed():
	#TODO make save logic

	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		finish()
		
func finish():
	get_tree().change_scene_to_file(main_menu_file_path)

func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()
