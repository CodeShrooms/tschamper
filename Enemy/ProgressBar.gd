extends ProgressBar


func _ready():
	value = 100

func _on_testmob_update_lives(lives, max_lives):
	value = lives * 100 / max_lives
