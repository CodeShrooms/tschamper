extends RichTextLabel

# Speed of scrolling
var base_scroll_speed : int = 60
var current_scroll_speed : int = base_scroll_speed
# Factor to increase speed when holding up/down keys
var speed_up_factor : int = 10

var scroll_speed : int = base_scroll_speed

var speed_up : bool = false


var credits_file_path : String = "res://scenes/main_screen/files/credits.txt"
var main_menu_file_path : String = "res://scenes/main_screen/scenes/Menu.tscn"

# The root node of the script is $"."
@onready var credits_text_label : Node = $"."

func _ready():
	var credits_text : String = load_text_from_file(credits_file_path)
	credits_text_label.text = credits_text
	# make scrollbar of ScrollContainer invisible
	credits_text_label.get_v_scroll_bar().scale.x = 0
	
	# Set the initial position to the top
	position.y = 0
	
	# Adjust the size of the label based on the text content
	credits_text_label.size.y = credits_text_label.get_content_height()


func _process(delta):
	# Adjust scroll speed based on whether speed_up is true or false
	current_scroll_speed = base_scroll_speed * speed_up_factor if speed_up else base_scroll_speed

	# Move the RichTextLabel content upwards
	position.y -= current_scroll_speed * delta

	# Check if the content has reached the end
	if position.y < -size.y:
		# Reset the position to the bottom to create a loop
		position.y = 0
		
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
	if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_up")) and !event.is_echo():
		speed_up = true
	if (event.is_action_released("ui_down") || event.is_action_released("ui_up")) and !event.is_echo():
		speed_up = false


