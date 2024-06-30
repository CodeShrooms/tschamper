extends Control

@onready var firstLevelPreloaded = preload("res://Components/levels/test_level.tscn")
@onready var videoPlayer = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	videoPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_video_stream_player_finished():
	start_game()

func start_game():
	get_tree().change_scene_to_packed(firstLevelPreloaded)


func _on_skip_intro_button_pressed():
	start_game()
