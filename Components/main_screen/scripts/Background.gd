extends TextureRect

var main_menu_file_path : String = "res://Components/main_screen/scenes/Menu.tscn"

@onready var credit_screen_root_node: Node2D = $".."

func _process(delta):

	# Move the RichTextLabel content upwards
	self.position.y -= credit_screen_root_node.current_scroll_speed * delta

	# Check if the content has reached the end
	if self.position.y < -self.size.y:
		# Call finish() when the entire text has scrolled out of view
		credit_screen_root_node.finish()

