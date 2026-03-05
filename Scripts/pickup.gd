@tool
extends Area2D

@export var state : Global.States

func _ready():
	match state:
		Global.States.HEART: $AnimatedSprite2D.play("heart")
		Global.States.SCORE: $AnimatedSprite2D.play("score")
		Global.States.ATTACK: $AnimatedSprite2D.play("attack")

func _process(_dt):
	if Engine.is_editor_hint():
		match state:
			Global.States.HEART: $AnimatedSprite2D.play("heart")
			Global.States.SCORE: $AnimatedSprite2D.play("score")
			Global.States.ATTACK: $AnimatedSprite2D.play("attack")

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	body.add_pickup(state)
	queue_free()
