extends Control

const default_db = 40

const master_bus = 0
const music_bus = 1
const sfx_bus = 2


func _on_master_default_pressed():
	set_volume(master_bus, default_db)
	set_slider_default($CenterContainer/HBoxContainer/Slider/MasterVolumeSlider)


func _on_music_default_pressed():
	set_volume(music_bus, default_db)
	set_slider_default($CenterContainer/HBoxContainer/Slider/MusicVolumeSlider)


func _on_sfx_default_pressed():
	set_volume(sfx_bus, default_db)
	set_slider_default($CenterContainer/HBoxContainer/Slider/SFXVolumeSlider)


func _on_master_volume_slider_value_changed(value):
	set_volume(master_bus, value)


func _on_music_volume_slider_value_changed(value):
	set_volume(music_bus, value)


func _on_sfx_volume_slider_value_changed(value):
	set_volume(sfx_bus, value)

func set_volume(bus_index, volume):
	AudioServer.set_bus_volume_db(bus_index, volume)

func set_slider_default(slider_node):
	slider_node.value = 100
