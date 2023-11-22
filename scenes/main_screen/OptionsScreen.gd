extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_back_pressed():
	var mainMenuScreen = $"../MainMenuScreen"
	var currentScreen = $"."

	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		# Nodes don't exist, return to MainMenu
		get_tree().change_scene_to_file("res://scenes/main_screen/Menu.tscn")


func _on_save_pressed():
	#TODO make save logic
	var mainMenuScreen = $"../MainMenuScreen"
	var currentScreen = $"."

	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		# Nodes don't exist, return to MainMenu
		get_tree().change_scene_to_file("res://scenes/main_screen/Menu.tscn")
