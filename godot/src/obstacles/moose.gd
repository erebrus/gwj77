extends Node2D
class_name Moose

@export var speed:=50.0
func _physics_process(delta: float) -> void:
	position+=Vector2.UP*speed*delta
	
func enter(sled: Sled) -> void:
	sled.get_parent().crash()
