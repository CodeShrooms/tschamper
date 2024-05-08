extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("save_game"):
		print("saving game....")
		
		save_game(0) # TODO: var current_slot
		
		print("Game saved!")


func save_game(slot: int):
	var path = "user://savegame%s.save"
	
	print("saving into '%s'", path % slot)
	
	var save_file = FileAccess.open(path % slot, FileAccess.WRITE)
	
	# all nodes in the level that need to be saved must be in the "persist" group
	var persist_nodes = get_tree().get_nodes_in_group("persist")
	print("number of nodes in TestLevel: ", persist_nodes.size()) # FIXME: remove this!
	
	# much of this save-game-logic is from https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
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

func load_game(slot: int):
	var path = "user://savegame%s.save"
	if not FileAccess.file_exists(path % slot):
		return # Error! We don't have a save to load.
