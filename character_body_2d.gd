extends CharacterBody2D

@export var speed = 200

func _physics_process(dt):
	var horizontal_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = horizontal_movement * speed
	move_and_slide()
	
	
func _input(event : InputEvent) -> void:
	if event.is_action_pressed("prone") and is_on_floor():
		# prone logic
		pass
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		# Pause menu
		print("Pause menu!")
		
		
