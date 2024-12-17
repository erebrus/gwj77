class_name Dog extends Node2D

@onready var lead_marker: Marker2D = %LeadMarker
@onready var sprite: AnimatedSprite2D = $AnimatedSprite


var height: float:
	set(value):
		if value != height:
			height = value
			sprite.position.y = height
	
func on_jumped():
	sprite.play("jump")
	
func on_landed():
	sprite.play("land")
	await sprite.animation_finished
	sprite.play("default")
