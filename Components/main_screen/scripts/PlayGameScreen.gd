extends Control

var main_menu_file_path = "res://Components/main_screen/scenes/Menu.tscn"
var introduction_video_scene_path = "res://Components/main_screen/scenes/introduction_video.tscn"

@onready var mainMenuScreen = %MenuScreen
@onready var currentScreen = $"."

func _on_slot_1_button_pressed():
	start_game()

func _on_slot_2_button_pressed():
	start_game()

func _on_slot_3_button_pressed():
	start_game()
	
func start_game():
	#TODO add save logic here
	#TODO let the player name their Slot and save Slot Name
	get_tree().change_scene_to_file(introduction_video_scene_path)
	

func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()

func _on_back_pressed():
	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		# Nodes don't exist, return to MainMenu
		finish()
		
func finish():
	get_tree().change_scene_to_file(main_menu_file_path)
