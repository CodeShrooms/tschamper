extends RichTextLabel

var credits_file_path: String = "res://scenes/main_screen/files/credits.txt"
var main_menu_file_path: String = "res://scenes/main_screen/scenes/Menu.tscn"

@onready var credit_screen_root_node: Node2D = $"../../.."

func _ready():
	# Add multiple newlines so the text of the credits file is on the bottom of the screen.
	# Initial set in UI text box would be more ugly and \n's could not be counted (and it doesnt work).
	for i in range(23):
		self.append_text("\n")
	
	# Get and set text of the Credits.
	var credits_text : String = load_text_from_file(credits_file_path)
	# Center the text.
	self.append_text("[center]")
	self.append_text(credits_text)

	# Set the initial position to the top of the text
	self.position.y = 0
	
	# Adjust the size of the label based on the text content
	self.size.y = self.get_content_height()


func _process(delta):

	# Move the RichTextLabel content upwards
	self.position.y -= credit_screen_root_node.current_scroll_speed * delta

	# Check if the content has reached the end
	if self.position.y < -self.size.y:
		# Call finish() when the entire text has scrolled out of view
		credit_screen_root_node.finish()
		

func load_text_from_file(file_path : String) -> String:
	var file : FileAccess = FileAccess.open(file_path, FileAccess.READ)
	
	# Open the file in read mode
	if file != null:
		# Read the entire content of the file
		var text_content : String = file.get_as_text()
		
		file.close()
		
		# Return the text content
		return text_content
	else:
		print("Error opening file:", credits_file_path)
		return ""  # Return an empty string if there's an error
