extends AnimatableBody2D

@export var crate_path : Path2D
@export var crate_path_follow : PathFollow2D
var speed
@export var time = 5

func _ready():
	speed = (float)(crate_path.curve.get_baked_length()/time)

func _process(dt):
	crate_path_follow.progress += speed * dt
