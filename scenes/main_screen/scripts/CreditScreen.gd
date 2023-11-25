extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100.0
const speed_up_multiplier := 10.0
const title_color := Color.INDIGO

# 
var scroll_speed := base_speed
var speed_up := false

@onready var line := $CenterContainer/CreditsContainer/Line

var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var main_menu_file_path = "res://scenes/main_screen/scenes/Menu.tscn"
var credits_file_path = "res://scenes/main_screen/files/credits.txt"
var credits := []

func _ready():
	load_credits_from_file()

func _process(delta):
	scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			# Use the position property of the container
			l.position.y -= scroll_speed
		
			# Check the position of the container
			if l.position.y < -l.size.y:
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene_to_file(main_menu_file_path)

func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		# there is no setter for colour, therefore setting it manually
		new_line.set("theme_override_colors/font_color", title_color)
	
	$CenterContainer/CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()
	if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up")) and !event.is_echo():
		speed_up = true
	if (event.is_action_released("ui_down") || event.is_action_released("ui_up")) and !event.is_echo():
		speed_up = false


func load_credits_from_file():
	var file = FileAccess.open(credits_file_path, FileAccess.READ)
	if file == null:
		print("Error opening file:", credits_file_path)
		return

	var section = []
	while !file.eof_reached():
		var line_in_file = file.get_line().strip_edges()
		if line_in_file != "":
			section.append(line_in_file)
		elif section.size() > 0:
			credits.append(section)
			section = []

	# Add the last section if it exists
	if section.size() > 0:
		credits.append(section)

	file.close()



func _on_back_pressed():
	finish()
