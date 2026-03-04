extends Node

# player specific global variables for access by other scripts
var is_climbing = false
var is_attacking = false

# bomb spawn variables
var is_bomb_moving = false

# scene variables
var current_scene

func _ready():
	current_scene = get_tree().get_current_scene().name
