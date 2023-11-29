extends Control

@onready var mainMenuScreen = %MenuScreen
@onready var optionsScreen = %OptionsScreen
@onready var playGameScreen = %PlayGameScreen

var credits_screen_file_path = "res://scenes/main_screen/scenes/CreditScreen.tscn"

func _ready():
	#select New Game Button with keyboard
	%MenuScreen/VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	playGameScreen.visible = true
	mainMenuScreen.visible = false

func _on_options_pressed():
	optionsScreen.visible = true
	mainMenuScreen.visible = false

func _on_credits_pressed():
	get_tree().change_scene_to_file(credits_screen_file_path)

func _on_quit_pressed():
	get_tree().quit()
