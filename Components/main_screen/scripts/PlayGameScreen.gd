extends Control

var main_menu_file_path = "res://Components/main_screen/scenes/Menu.tscn"
var first_game_scene_file_path = "res://Components/levels/test_level.tscn"

@onready var mainMenuScreen = %MenuScreen
@onready var currentScreen = $"."
@onready var first_level_preloaded : PackedScene = preload("res://Components/levels/test_level.tscn")

func _on_slot_1_button_pressed():
	start_game(1)

func _on_slot_2_button_pressed():
	start_game(2)

func _on_slot_3_button_pressed():
	start_game(3)
	
func start_game(slot : int):
	print("starting game of slot %d" % slot)
	#TODO let the player name their Slot and save Slot Name
	var level_node: Node = first_level_preloaded.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	
	load_game(slot, level_node)
	level_node.set("current_slot", slot)
	var wrapper_scene: PackedScene = PackedScene.new()
	wrapper_scene.pack(level_node)
	get_tree().change_scene_to_packed(wrapper_scene)


func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()

func _on_back_pressed():
	if mainMenuScreen and currentScreen:
		mainMenuScreen.visible = true
		currentScreen.visible = false
	else:
		# Nodes don't exist, return to MainMenu
		finish()
		
func finish():
	get_tree().change_scene_to_file(main_menu_file_path)


func load_game(slot: int, level_node: Node):
	# takes the level, removes all "persist"-Nodes, opens a save_file and loads the nodes specified in it 
	
	# much of this load-game-logic is from https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
	
	var path = "user://savegame%d.save"
	if not FileAccess.file_exists(path % slot):
		print("no save for slot %d!" % slot)
		return # Error! We don't have a save to load.
	
	print("Save for slot %d exists!" % slot)
	
	# remove 'persist' nodes to only load those specified in the save_file
	remove_nodes_from_group_below_node(level_node, "persist")
	
	var save_file = FileAccess.open(path % slot, FileAccess.READ)
	# go through save_file:
	while save_file.get_position() < save_file.get_length():
		#====Parse-Line====
		var json_string = save_file.get_line()
		
		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = JSON.parse_string(json_string)
		if parse_result == null:
			print("JSON Parse Error when loading %s", path % slot)
			continue
		
		# result is of this structure: e.g. { "Player": {Dictionary(size 4)}}
		# this needs to be unpacked to get the inner Dictionary
		var node_data: Dictionary
		for node in parse_result:
			node_data = parse_result[node]
		
		#====Use-parsed-line====
		# Create Object, add to correct parent, set position
		var new_object = load(node_data["filename"]).instantiate()
		#level_node.get_node(node_data["parent"]).add_child(new_object)
		level_node.add_child(new_object)
		new_object.position = Vector2(node_data["position_x"], node_data["position_y"])
		print("position of %s: %s" % [new_object.name, Vector2(node_data["position_x"], node_data["position_y"])])
		
		#new_object.set_position(Vector2(node_data["position_x"], node_data["position_y"]))
		
		# remove variables from node_data, so the rest can be set more easily
		node_data.erase("filename")
		node_data.erase("parent")
		node_data.erase("position")
		
		# Set the remaining variables.
		for node_variable in node_data.keys():
			new_object.set(node_variable, node_data[node_variable])
			

func remove_nodes_from_group_below_node(node: Node, group_name: String):
	# recursively looks below 'node' for nodes in 'group_name' and queue_free's them
	for n in find_node_descendants_in_group(node, group_name):
		print("removing node %s" % n.name)
		n.queue_free()

func find_node_descendants_in_group(node: Node, group_name: String) -> Array:
	# recursively looks below 'node' for nodes in 'group_name' and returns them
	# source: https://www.reddit.com/r/godot/comments/i5wpzz/comment/g0sqe5q/
	var descendantsInGroup := []
	for child in node.get_children():
		if child.is_in_group(group_name):
			descendantsInGroup.append(child)
		descendantsInGroup += find_node_descendants_in_group(child, group_name)
	return descendantsInGroup
