extends Area2D

func _ready():
	$AnimatedSprite2D.play("moving")
	Global.is_bomb_moving = true

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player" and body.name != "BombReceiver":
		return
	$AnimatedSprite2D.play("explode")
	$Timer.start()


func _on_timer_timeout() -> void:
	if is_instance_valid(self):
		queue_free()
	Global.is_bomb_moving = false
