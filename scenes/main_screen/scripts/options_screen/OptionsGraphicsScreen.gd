extends Control

func _ready():
	update_button_values()

func set_resolution(width, height):
	get_viewport().size = Vector2i(width, height)

func _on_option_button_item_selected(index):
	var selected_option = $CenterContainer/HBoxContainer/Checks/ResolutionSelect.get_item_text(index)
	match selected_option:
		"1920x1080":
			set_resolution(1920, 1080)
		"720x480":
			set_resolution(720, 480)
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

func _on_full_screen_default_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	update_button_values()

func _on_vsync_default_pressed():
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	update_button_values()

func _on_resolution_default_pressed():
	set_resolution(1920, 1080)
	update_button_values()
	
func update_button_values():
	#set default checkbox values//check which options are 4real currently enabled
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
	match get_viewport().get_size():
		Vector2i(1920, 1080):
			$CenterContainer/HBoxContainer/Checks/ResolutionSelect.selected = 0
		Vector2i(720, 480):
			$CenterContainer/HBoxContainer/Checks/ResolutionSelect.selected = 1
