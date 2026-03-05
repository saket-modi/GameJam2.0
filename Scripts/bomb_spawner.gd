extends Node2D

@export var bomb_path : PathFollow2D
@export var bomb_animation : AnimationPlayer
var bomb : PackedScene = preload("res://Scenes/bomb.tscn")

func _ready():
	$AnimatedSprite2D.play("idle")
	
func create_bomb():
	var temp = bomb.instantiate()
	$AnimatedSprite2D.play("firing")
	return temp

func _on_timer_timeout() -> void:
	if !Global.is_bomb_moving:
		# forceful cleanup
		# safety net in case bomb.gd cannot call queue_free()
		for child in bomb_path.get_children():
			child.queue_free()
			bomb_animation.stop()
	
	if bomb_path.get_child_count() <= 0:
		var new_bomb = create_bomb()
		new_bomb.bomb_exploded.connect(_on_bomb_exploded)
		
		bomb_path.add_child(new_bomb)
		bomb_animation.play("bomb_movement")
		Global.is_bomb_moving = true

func _on_bomb_exploded():
	bomb_animation.stop()
