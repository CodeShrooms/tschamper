extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#select New Game Button with keyboard
	$VBoxContainer/NewGame.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")


func _on_options_pressed():
	# Load the OptionsScreen scene and instance it
	var options_instance = load("res://scenes/main_screen/OptionsScreen.tscn")

	if options_instance:
		# Add the OptionsScreen as a child to the current scene
		get_tree().current_scene.add_child(options_instance)

		# Set the OptionsScreen instance as the active scene
		get_tree().current_scene = options_instance
	else:
		print("Failed to load OptionsScreen scene.")


func _on_quit_pressed():
	get_tree().quit()

