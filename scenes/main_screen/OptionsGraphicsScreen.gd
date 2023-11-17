extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func set_resolution(width, height):
	# Your code to set the game resolution goes here
	print("Setting resolution to:", width, "x", height)


func _on_option_button_item_selected(index):
	var selected_option = $HBoxContainer/Checks/OptionButton.get_item_text(index)
	match selected_option:
		"1920x1080":
			set_resolution(1920, 1080)
		"720x480":
			set_resolution(720, 480)
		# Add more options as needed
		_:
			print("Unknown option selected:", selected_option)
