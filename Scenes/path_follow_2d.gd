extends PathFollow2D

@export var speed = 10

func _process(dt):
	progress_ratio += speed / (dt * 500000) 
