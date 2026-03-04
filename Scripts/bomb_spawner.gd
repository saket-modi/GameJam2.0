extends Node2D

var bomb : PackedScene = preload("res://Scenes/bomb.tscn")
var current_scene_path
var bomb_path
var bomb_animation

func _ready():
	$AnimatedSprite2D.play("idle")
	var current_scene_path = Global.current_scene
	var bomb_path = current_scene_path + "/BombPath/Path2D/PathFollow2D"
	var bomb_animation = current_scene_path + "/BombPath/Path2D/AnimationPlayer"
	
func create_bomb():
	var temp = bomb.instantiate()
	$AnimatedSprite2D.play("firing")
	return temp

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("idle")
	if bomb_path.get_child_count() <= 0:
		bomb_path.add_child(create_bomb())
