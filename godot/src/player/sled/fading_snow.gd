extends Node2D
class_name FadingSnow

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	sprite.play("default")
	await sprite.animation_finished
	queue_free()
