extends Node2D

func _ready():
	$Body.play("matching")
	$SpeechBubble.visible = false
	
func _process(dt):
	if Global.is_bomb_moving:
		$SpeechBubble.visible = true
		if $Body.animation != "idle":
			$Body.play("idle")
		var chosen_time = randi_range(1, 10)
		if $Timer.is_stopped():
			$Timer.start(chosen_time)
	else:
		$SpeechBubble.visible = false
		if $Body.animation != "matching":
			$Body.play("matching")
	
func _on_timer_timeout() -> void:
	var chosen_animation = randi() % 3

	match chosen_animation:
		0: $SpeechBubble.play("boom")
		1: $SpeechBubble.play("loser")
		2: $SpeechBubble.play("swearing")
