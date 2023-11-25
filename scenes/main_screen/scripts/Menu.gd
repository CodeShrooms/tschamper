extends Control

@onready var mainMenuScreen = $MenuScreen
@onready var optionsScreen = $OptionsScreen

var first_level_file_path = "res://scenes/levels/test_level.tscn"
var credits_screen_file_path = "res://scenes/main_screen/scenes/CreditScreen.tscn"

func _ready():
	#select New Game Button with keyboard
	$MenuScreen/VBoxContainer/LoadGame.grab_focus()

func _on_load_game_pressed():
	pass # Replace with function body.

func _on_new_game_pressed():
	get_tree().change_scene_to_file(first_level_file_path)

func _on_options_pressed():
	optionsScreen.visible = true
	mainMenuScreen.visible = false

func _on_credits_pressed():
	get_tree().change_scene_to_file(credits_screen_file_path)

func _on_quit_pressed():
	get_tree().quit()
