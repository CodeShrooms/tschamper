class_name Level
extends Node2D

var current_slot: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("save_game"):
		print("saving game to slot %d...." % current_slot)
		
		save_game(current_slot)
		
		print("Game saved!")


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
