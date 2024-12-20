class_name Sled extends Area2D

const FADING_SNOW_SCENE:PackedScene=preload("res://src/player/sled/fading_snow.tscn")

@export var follow_component: FollowComponent
@export var jump_component: JumpComponent

@onready var snow_sprite: AnimatedSprite2D = $SnowSprite
@onready var sprite: AnimatedSprite2D = $JumpingBits/Sprite2D

var height: float:
	set(value):
		if value != height:
			height = value
			$JumpingBits.position.y = height
	
func _ready():
	snow_sprite.play("run")
	sprite.play("run")


func _on_jump_component_jumped() -> void:
	var fading_snow := FADING_SNOW_SCENE.instantiate() as FadingSnow
	fading_snow.global_position=snow_sprite.global_position
	get_parent().get_parent().add_child(fading_snow)
	snow_sprite.visible=false
	

func _on_jump_component_landed() -> void:
	snow_sprite.play("start")
	snow_sprite.visible=true
	await snow_sprite.animation_finished
	snow_sprite.play("run")
