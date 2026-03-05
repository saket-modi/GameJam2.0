@tool
extends Area2D

@export var next_scene : PackedScene

var can_switch = false
var plr

func _ready():
	$UI.visible = false
	if Engine.is_editor_hint():
		$UI.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	$AnimatedSprite2D.play("opening")
	plr = body
	can_switch = true
	
func _on_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	$AnimatedSprite2D.play("idle")
	can_switch = false
	
func _input(event : InputEvent):
	if event is InputEventKey and event.pressed and can_switch and event.keycode == KEY_E:
		if $AnimatedSprite2D.is_playing():
			return
		get_tree().paused = true
		$AnimatedSprite2D.play("closing")
		plr.get_node("UI").visible = false
		$UI.visible = true
		$AnimationPlayer.play("ui_visibility")

func _on_restart_pressed() -> void:
	get_tree().paused = false
	$UI.visible = false
	get_tree().reload_current_scene()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	$UI.visible = false
	get_tree().change_scene_to_packed(next_scene)
