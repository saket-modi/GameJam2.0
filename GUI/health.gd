extends ColorRect

@onready var label = $Label

func _update_lives(current_lives, MAX_LIVES):
	label.text = str(current_lives)
