extends Control

func _ready():
	#set default checkbox values
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			$CenterContainer/HBoxContainer/Checks/FullScreen.set_pressed_no_signal(true)
		DisplayServer.WINDOW_MODE_MAXIMIZED:
			$CenterContainer/HBoxContainer/Checks/FullScreen.set_pressed_no_signal(false)
	match DisplayServer.window_get_vsync_mode():
		DisplayServer.VSYNC_ENABLED:
			$"CenterContainer/HBoxContainer/Checks/V-sync".set_pressed_no_signal(true)
		DisplayServer.VSYNC_DISABLED:
			$"CenterContainer/HBoxContainer/Checks/V-sync".set_pressed_no_signal(false)
			

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
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_vsync_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
