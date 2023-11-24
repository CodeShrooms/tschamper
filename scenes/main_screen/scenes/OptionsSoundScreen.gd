extends Control

const default_db = 10

const master_bus = 0
const music_bus = 1
const sfx_bus = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	slider_default($CenterContainer/HBoxContainer/Slider/MasterVolumeSlider)
	slider_default($CenterContainer/HBoxContainer/Slider/MusicVolumeSlider)
	slider_default($CenterContainer/HBoxContainer/Slider/SFXVolumeSlider)


func _on_master_default_pressed():
	volume(master_bus, default_db)
	slider_default($CenterContainer/HBoxContainer/Slider/MasterVolumeSlider)


func _on_music_default_pressed():
	volume(music_bus, default_db)
	slider_default($CenterContainer/HBoxContainer/Slider/MusicVolumeSlider)


func _on_sfx_default_pressed():
	volume(sfx_bus, default_db)
	slider_default($CenterContainer/HBoxContainer/Slider/SFXVolumeSlider)


func _on_master_volume_slider_value_changed(value):
	volume(master_bus, value)


func _on_music_volume_slider_value_changed(value):
	volume(music_bus, value)


func _on_sfx_volume_slider_value_changed(value):
	volume(sfx_bus, value)

func volume(bus_index, volume):
	AudioServer.set_bus_volume_db(bus_index, volume)

func slider_default(slider_node):
	slider_node.value = 100
