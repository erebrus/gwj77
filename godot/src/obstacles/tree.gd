extends Node2D

@export var textures: Array[Texture]


@onready var sprite := $Sprite2D
@onready var shake_timer:= $ShakeTimer

func _ready():
	sprite.texture = textures.pick_random()
	sprite.material = sprite.material.duplicate()
	shake_timer.timeout.connect(_on_shake_timeout)
	

func enter(sled: Sled) -> void:
	sled.get_parent().crash()
	

func _on_shake_area_area_exited(area):
	sprite.material.set_shader_parameter("strength", 3)
	shake_timer.start()
	
	

func _on_shake_timeout():
	sprite.material.set_shader_parameter("strength", 0)
	
