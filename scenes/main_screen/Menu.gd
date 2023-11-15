extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#select New Game Button with keyboard
	$VBoxContainer/NewGame.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")


func _on_options_pressed():
	#var options = load("res://scenes/main_screen/OptionsScreen.tscn").instance()
	#get_tree().current_scene.add_child(options)
	pass


func _on_quit_pressed():
	get_tree().quit()
