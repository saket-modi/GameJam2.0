extends PathFollow2D

@export var time = 3
var speed

func _ready():
	speed = (float)(get_parent().curve.get_baked_length()/time)

func _process(dt):
	progress += speed * dt
