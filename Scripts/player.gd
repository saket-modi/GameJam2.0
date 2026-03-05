extends CharacterBody2D

signal update_lives(lives, max_lives)

@export var WALK_SPEED = 100
@export var SPRINT_SPEED = 200
@export var JUMP_SPEED = -250
@export var CLIMB_SPEED = -20
@export var MAX_ENERGY : float = 100
@export var ENERGY_RECOVERY_RATE = 10
@export var MAX_JUMPS = 1
@export var DEFAULT_GRAVITY = 500
@export var HEALTH = 100
@export var MAX_LIVES = 3

const INITIAL_SPRINT_CONSUMPTION_RATE = 10

var current_gravity = 100
var jump_speed = JUMP_SPEED
var move_speed = WALK_SPEED
var energy_recovery_rate = ENERGY_RECOVERY_RATE
var current_energy : float = 50
var attack_consumption_rate : float = 5
var sprint_consumption_rate : float = INITIAL_SPRINT_CONSUMPTION_RATE # rate of consumption of energy while sprinting (in energy/second)
var sprint_time : float = 0.0
var jump_count = 0
var current_lives = 3

var can_attack = true
var attack_cooldown : float = 0.2

func _ready():
	# Connect the update_lives signal to the _update_lives function in health.gd
	update_lives.connect($UI/Health._update_lives)

func _physics_process(dt):
	
	player_physics(dt)
	
	# if a player collides while moving, instead of going through the wall it will slide along it
	# better than position += velocity * dt as that allows player to go through walls
	move_and_slide()
	
	player_animations()
		
	# increase energy every second
	if $EnergyTime.is_stopped():
		$EnergyTime.start()
		

func player_physics(dt):
	if Global.is_attacking:
		return
		
	if Global.is_climbing:
		if Input.is_action_pressed("climb"):
			current_gravity = 0
			velocity.y = CLIMB_SPEED
	else:
		current_gravity = DEFAULT_GRAVITY
		if not is_on_floor():
			velocity.y += current_gravity * dt
		else:
			jump_count = 0
	# controls
	# strength corresponds to joystick controls (how far down the button is pressed or how much the analog is moved)
	var horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_pressed("prone"):
		# make collision shape y axis scale smaller and change sprite
		pass
	if Input.is_action_pressed("sprint") and current_energy > sprint_consumption_rate and velocity.x != 0:
		move_speed = SPRINT_SPEED
		if $SprintTimer.is_stopped():
			$SprintTimer.start()
	else:
		$SprintTimer.stop()
		move_speed = WALK_SPEED
		sprint_time = 0
		
		if sprint_consumption_rate > INITIAL_SPRINT_CONSUMPTION_RATE and $SprintRecovery.is_stopped():
			$SprintRecovery.start()
		
	velocity.x = horizontal_input * move_speed
	
func _input(event : InputEvent) -> void: # "interrupt" like handling of inputs
	if event.is_action_pressed("jump") and jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y += JUMP_SPEED
		get_viewport().set_input_as_handled()
		
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		# Pause menu
		print("Pause menu!") 
	
	if event.is_action_pressed("attack"):
		if current_energy >= attack_consumption_rate and can_attack == true and $AnimatedSprite2D.animation != "attack":
			Global.is_attacking = true
			can_attack = false
			$AttackRecovery.start(attack_cooldown)

			var facing = -1 if $AnimatedSprite2D.flip_h else 1
			velocity.x = velocity.x + facing * (float)(SPRINT_SPEED)/2
			
			get_viewport().set_input_as_handled()
	
func player_animations():
	
	if not is_on_floor():
		if velocity.y < 0 and $AnimatedSprite2D.animation != "up":
			$AnimatedSprite2D.play("up")
		if velocity.y > 0 and $AnimatedSprite2D.animation != "fall": # falling
			$AnimatedSprite2D.play("fall")
		return
		
	if Global.is_attacking:
		if $AnimatedSprite2D.animation != "attack":
			$AnimatedSprite2D.play("attack")
		return
		
	if Global.is_climbing:
		if $AnimatedSprite2D.animation != "climb":
			$AnimatedSprite2D.play("climb")
		return
		
	if Input.is_action_pressed("move_left") or Input.is_action_just_released("jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("move_right") or Input.is_action_just_released("jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
		
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
		
func take_damage():
	if current_lives > 0:
		current_lives -= 1
		$AnimatedSprite2D.play("damage")
		
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, 0.1)
		tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.1)
		
		set_physics_process(false)
		update_lives.emit(current_lives, MAX_LIVES)
		
func add_pickup(pickup):
	if pickup == Global.States.HEART:
		if current_lives < MAX_LIVES:
			current_lives += 1
			update_lives.emit(current_lives, MAX_LIVES)
	elif pickup == Global.States.SCORE:
		pass
	elif pickup == Global.States.ATTACK:
		pass

func _on_sprint_timer_timeout() -> void:
	# sprint consumption should increase at a rate of sqrt(sprint_time) * initial_rate per second
	sprint_time = sprint_time + $SprintTimer.wait_time
	sprint_consumption_rate = sprint_consumption_rate + sprint_time * INITIAL_SPRINT_CONSUMPTION_RATE
	current_energy = max(0, current_energy - sprint_consumption_rate)

func _on_energy_time_timeout() -> void:
	# increase energy at a linear rate per second
	current_energy = min(MAX_ENERGY, current_energy + ENERGY_RECOVERY_RATE)

func _on_sprint_recovery_timeout() -> void:
	# sprint consumption decreases at a rate of initial_rate per second
	sprint_consumption_rate = max(INITIAL_SPRINT_CONSUMPTION_RATE, sprint_consumption_rate - INITIAL_SPRINT_CONSUMPTION_RATE)


func _on_attack_recovery_timeout() -> void:
	can_attack = true


func _on_animated_sprite_2d_animation_finished() -> void:
	Global.is_attacking = false
	set_physics_process(true)
	$AnimatedSprite2D.play("idle")
