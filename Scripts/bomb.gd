extends Area2D

signal bomb_exploded

var rotation_speed = 5

func _ready():
	$AnimatedSprite2D.play("moving")
	Global.is_bomb_moving = true
	
func _process(dt):
	if Global.is_bomb_moving:
		$AnimatedSprite2D.rotation += rotation_speed * dt

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.name == "BombReceiver":
		$AnimatedSprite2D.play("explode")
		if body.name == "Player":
			body.take_damage()
		$Timer.start(0.1)

func _on_timer_timeout() -> void:
	bomb_exploded.emit()
	if is_instance_valid(self):
		queue_free()
	Global.is_bomb_moving = false
