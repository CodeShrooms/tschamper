extends Control

@onready var mainMenuScreen = %MenuScreen
@onready var optionsScreen = %OptionsScreen
@onready var playGameScreen = %PlayGameScreen

# Needs to preload for importing reading the credits file etc. 
# Without reloading it takes a second to change the scene.
@onready var creditScenePreloaded = preload("res://Components/main_screen/scenes/CreditScreen.tscn")

var credits_screen_file_path = "res://Components/main_screen/scenes/CreditScreen.tscn"

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
	# Here change scene and not only visibility because of the music of the credits screen.
	get_tree().change_scene_to_packed(creditScenePreloaded)

func _on_quit_pressed():
	get_tree().quit()
