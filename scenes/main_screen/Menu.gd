extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#select New Game Button with keyboard
	$MainMenuScreen/VBoxContainer/NewGame.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")


func _on_options_pressed():
	$OptionsScreen.visible = true
	$MainMenuScreen.visible = false


func _on_quit_pressed():
	get_tree().quit()

