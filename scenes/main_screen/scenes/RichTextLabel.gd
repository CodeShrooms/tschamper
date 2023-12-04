extends RichTextLabel

# Speed of scrolling.
var base_scroll_speed : int = 60
var current_scroll_speed : int = base_scroll_speed
# Factor to increase speed when holding up/down keys.
var speed_up_factor : int = 10
# Is the speed currently increased?
var speed_up : bool = false

var credits_file_path : String = "res://scenes/main_screen/files/credits.txt"
var main_menu_file_path : String = "res://scenes/main_screen/scenes/Menu.tscn"

func _ready():
	# Add multiple newlines so the text of the credits file is on the bottom of the screen.
	# Initial set in UI text box would be more ugly and \n's could not be counted.
	for i in range(26):
		self.append_text("\n")
	
	# Get and set text of the Credits.
	var credits_text : String = load_text_from_file(credits_file_path)
	self.append_text(credits_text)

	# Set the initial position to the top of the text
	self.position.y = 0
	
	# Adjust the size of the label based on the text content
	self.size.y = self.get_content_height()


func _process(delta):
	# Adjust scroll speed based on whether speed_up is true or false
	current_scroll_speed = base_scroll_speed if (not speed_up) else (base_scroll_speed * speed_up_factor)

	# Move the RichTextLabel content upwards
	self.position.y -= current_scroll_speed * delta

	# Check if the content has reached the end
	if self.position.y < -self.size.y:
		# Call finish() when the entire text has scrolled out of view
		finish()
		

func load_text_from_file(file_path : String) -> String:
	var file : FileAccess = FileAccess.open(file_path, FileAccess.READ)
	
	# Open the file in read mode
	if file != null:
		# Read the entire content of the file
		var text_content : String = file.get_as_text()
		
		# Close the file
		file.close()
		
		# Return the text content
		return text_content
	else:
		print("Error opening file:", credits_file_path)
		return ""  # Return an empty string if there's an error

func finish():
	get_tree().change_scene_to_file(main_menu_file_path)

	
func _unhandled_input(event):
	# If you press Esc return to MainScreen
	if event.is_action_pressed("ui_cancel"):
		finish()

	# event.is_echo() might be triggered when a key is held down, we dont want the echo behaviour.
	if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up")) and !event.is_echo():
		speed_up = true
	if (event.is_action_released("ui_down") || event.is_action_released("ui_up")) and !event.is_echo():
		speed_up = false


