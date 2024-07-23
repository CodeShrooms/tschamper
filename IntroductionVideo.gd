extends Control

@onready var firstLevelPreloaded = preload("res://Components/levels/test_level.tscn")
@onready var videoPlayer = $VideoStreamPlayer
@onready var skipButton = $SkipIntroButton

# Called when the node enters the scene tree for the first time.
func _ready():
	# Ensure the video stream is properly set up and starts playing
	videoPlayer.stream = load("res://Assets/MainScreen/demo_placeholder_intro.ogv")
	videoPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Function called when the video finishes playing
func _on_video_stream_player_finished():
	start_game()

# Function to start the game by changing to the first level scene
func start_game():
	get_tree().change_scene_to_packed(firstLevelPreloaded)

# Function to handle skip intro button pressed event
func _on_skip_intro_button_pressed():
	start_game()
