class_name JumpComponent extends Node

signal jumped
signal landed

@export var target: Node2D

@export var down_gravity_factor:float = 1.5
@export var gravity: float = 200
@export var impulse: float = -100

var speed = 0
var height = 0:
	set(value):
		if value != height:
			height = value
			target.height = height
	

func is_on_ground() -> bool:
	return height == 0
	

func jump() -> void:
	if not is_on_ground():
		return
	
	speed = impulse
	jumped.emit()
	

func _physics_process(delta: float) -> void:
	var was_on_ground= is_on_ground()
	if speed != 0 or height != 0:
		speed += (gravity if speed < 0 else gravity * down_gravity_factor) * delta			
		height = min(0, height + speed * delta)
		
		if is_on_ground():
			speed = 0
			if not was_on_ground:
				landed.emit()
	
