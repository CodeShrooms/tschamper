class_name Level
extends Node2D

var current_slot: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("save_game"):
		print("saving game to slot %d...." % current_slot)
		
		#save_game(current_slot)
		save_game_via_scene_files(current_slot)
		
		print("Game saved!")
		
	elif Input.is_action_just_pressed("debug"):
		print("persist_nodes: ", get_tree().get_nodes_in_group("persist"))
		print("tree: ", get_node("Level1"))


func save_game(slot: int):
	# takes the important variables of "persist"-group Nodes and saves each Node as a line in save_file
	
	# much of this save-game-logic is from https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
	var path = "user://savegame%d.save"
	var save_file = FileAccess.open(path % slot, FileAccess.WRITE)
	
	# all nodes in the level that need to be saved must be in the "persist" group
	var persist_nodes = get_tree().get_nodes_in_group("persist")
	print("number of nodes in TestLevel: ", persist_nodes.size()) # FIXME: remove this!
	
	for node in persist_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue # with next node, don't do the statements below this for this node
		
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue # with next node, don't do the statements below this for this node
		
		# Call the node's save function.
		var node_data = {
			node.name: node.call("save")
		}
		
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)


func save_game_via_scene_files(slot: int):
	print("\nsave_game_via_scene_files():\n")
	var path = "user://game_saves/slot%d" % slot
	
	# ensure this slot's save directory exists:
	DirAccess.make_dir_recursive_absolute(path)
	
	
	# all nodes in the level that need to be saved must be in the "persist" group
	var persist_nodes = get_tree().get_nodes_in_group("persist")
	print("number of nodes in TestLevel: ", persist_nodes.size()) # FIXME: remove this!
	
	for node in persist_nodes:
		# pack the node in a PackedScene
		var scene = PackedScene.new()
		var result = scene.pack(node)
		
		var path_for_saved_node : String = path + "/%s.tscn" % node.name
		
		if result == OK:
			# according to https://www.reddit.com/r/godot/comments/11n7a8i/cant_save_changes_using_resourcesaver/
			# every variable that needs to be saved, must be @export
			var error = ResourceSaver.save(scene, path_for_saved_node)
			if error != OK:
				push_error("An error occurred while saving the scene to disk.")
		else:
			print("result of saving %s: NOT ok!!" % node.name)

