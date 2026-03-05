extends ColorRect

func _ready():
	visible = false

func _on_death():
	visible = true
	$"../../AnimationPlayer".play("ui_visibility")
	$"../../UI".visible = false
	get_tree().paused = true
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/level1.tscn")
