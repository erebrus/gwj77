extends Node2D

@export var textures: Array[Texture]


@onready var sprite := $Sprite2D

func _ready():
	$Sprite2D.texture = textures.pick_random()
	sprite.material = sprite.material.duplicate()
	
func enter(sled: Sled) -> void:
	sled.get_parent().crash()
	

func _on_shake_area_area_exited(area):
	sprite.material.set_shader_parameter("strength", 3)
	await get_tree().create_timer(1).timeout
	sprite.material.set_shader_parameter("strength", 0)
