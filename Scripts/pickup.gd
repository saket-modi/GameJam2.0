@tool
extends Area2D

enum States {HEART, SCORE, ATTACK}

@export var state : States

func _ready():
	match state:
		States.HEART: $AnimatedSprite2D.play("heart")
		States.SCORE: $AnimatedSprite2D.play("score")
		States.ATTACK: $AnimatedSprite2D.play("attack")

func _process(_dt):
	if Engine.is_editor_hint():
		match state:
			States.HEART: $AnimatedSprite2D.play("heart")
			States.SCORE: $AnimatedSprite2D.play("score")
			States.ATTACK: $AnimatedSprite2D.play("attack")

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	queue_free()
