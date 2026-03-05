extends Node

# player specific global variables for access by other scripts
var is_climbing = false
var is_attacking = false

enum States {HEART, SCORE, ATTACK}

# bomb spawn variables
var is_bomb_moving = false
