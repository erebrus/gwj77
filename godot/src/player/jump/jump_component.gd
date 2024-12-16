class_name JumpComponent extends Node

signal jumped

@export var target: Node2D

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
	if speed != 0 or height != 0:
		speed += gravity * delta
		height = min(0, height + speed * delta)
		
		if is_on_ground():
			speed = 0
	
