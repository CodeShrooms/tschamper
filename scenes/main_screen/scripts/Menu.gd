extends Control

@onready var mainMenuScreen = $MenuScreen
@onready var optionsScreen = $OptionsScreen
@onready var creditsScreen = $CreditScreen

var firs_level_file_path = "res://scenes/levels/test_level.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	#select New Game Button with keyboard
	$MenuScreen/VBoxContainer/LoadGame.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_load_game_pressed():
	pass # Replace with function body.

func _on_new_game_pressed():
	get_tree().change_scene_to_file(firs_level_file_path)

func _on_options_pressed():
	optionsScreen.visible = true
	mainMenuScreen.visible = false

func _on_credits_pressed():
	creditsScreen.visible = true
	mainMenuScreen.visible = false

func _on_quit_pressed():
	get_tree().quit()
