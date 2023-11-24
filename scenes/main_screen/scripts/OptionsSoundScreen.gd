extends Control

const DEFAULT_DB = linear_to_db(40)

const MASTER_BUS_ID = 0
const MUSIC_BUS_ID = 1
const SFX_BUS_ID = 2

@onready var master_volume_slider = %MasterVolumeSlider
@onready var music_volume_slider =%MusicVolumeSlider
@onready var sfx_volume_slider =%SFXVolumeSlider

func _on_master_default_pressed():
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, DEFAULT_DB)
	set_slider_default(master_volume_slider)


func _on_music_default_pressed():
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, DEFAULT_DB)
	set_slider_default(music_volume_slider)


func _on_sfx_default_pressed():
	AudioServer.set_bus_volume_db(SFX_BUS_ID, DEFAULT_DB)
	set_slider_default(sfx_volume_slider)


func _on_master_volume_slider_value_changed(volume):
	set_volume(MASTER_BUS_ID, volume)

func _on_music_volume_slider_value_changed(volume):
	set_volume(MUSIC_BUS_ID, volume)

func _on_sfx_volume_slider_value_changed(volume):
	set_volume(SFX_BUS_ID, volume)

func set_slider_default(slider_node):
	slider_node.value = 80 # in percent
	
func set_volume(bus_id, volume):
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(volume))
	AudioServer.set_bus_mute(bus_id, volume < .05)
