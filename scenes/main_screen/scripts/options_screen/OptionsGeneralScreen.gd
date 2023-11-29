extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_button_values()


func _on_language_select_item_selected(index):
	var selected_option = $CenterContainer/HBoxContainer/Checks/LanguageSelect.get_item_text(index)
	match selected_option:
		"English":
			TranslationServer.set_locale("en")
		"Deutsch":
			TranslationServer.set_locale("de")
		_:
			print("Unknown option selected:", selected_option)

func update_button_values():
	#set the users OS language as default
	match OS.get_locale_language():
		"en":
			$CenterContainer/HBoxContainer/Checks/LanguageSelect.selected = 0
		"de":
			$CenterContainer/HBoxContainer/Checks/LanguageSelect.selected = 1
		_:
			#default language is english
			$CenterContainer/HBoxContainer/Checks/LanguageSelect.selected = 0


func _on_language_default_pressed():
	TranslationServer.set_locale(OS.get_locale_language())
	update_button_values()

