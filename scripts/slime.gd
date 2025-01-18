extends Node2D

const SPEED = 60
var DIR = 1
@onready var ray_cast_right: RayCast2D = $RaycastRight
@onready var ray_cast_left: RayCast2D = $RaycastLeft
@onready var animated_spite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		DIR = -1
		animated_spite.flip_h = true
	if ray_cast_left.is_colliding():
		DIR = 1
		animated_spite.flip_h = true
	
	position.x+= DIR * SPEED * delta
	
