extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_resolution(width, height):
	get_viewport().size = Vector2i(width, height)

func _on_option_button_item_selected(index):
	var selected_option = $CenterContainer/HBoxContainer/Checks/ResolutionSelect.get_item_text(index)
	match selected_option:
		"1920x1080":
			set_resolution(1920, 1080)
		"720x480":
			set_resolution(720, 480)
		# Add more options as needed
		_:
			print("Unknown option selected:", selected_option)


func _on_full_screen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
