extends Node2D

@export var big_snowy_textures: Array[Texture]
@export var small_snowy_textures: Array[Texture]

@export var big_textures: Array[Texture]
@export var small_textures: Array[Texture]


@onready var sprite := $Sprite2D
@onready var snow_sprite := $SnowSprite
@onready var shake_timer:= $ShakeTimer

var texture_index: int
var is_snowy:= true

func _ready():
	texture_index = randi() % (big_snowy_textures.size() + small_snowy_textures.size())
	if texture_index < big_snowy_textures.size():
		sprite.texture = big_snowy_textures[texture_index]
		
	else:
		sprite.texture = small_snowy_textures[texture_index-big_snowy_textures.size()]
	
	sprite.material = sprite.material.duplicate()
	shake_timer.timeout.connect(_on_shake_timeout)
	

func enter(sled: Sled) -> void:
	sled.get_parent().crash()
	$sfx.play()
	

func _shake() -> void:
	if shake_timer.is_inside_tree():
		sprite.material.set_shader_parameter("strength", 3)
		shake_timer.start()
		
		if is_snowy:
			is_snowy = false
			await get_tree().create_timer(0.1).timeout
			snow_sprite.show()
			
			if texture_index < big_snowy_textures.size():
				sprite.texture = big_textures[texture_index]
				snow_sprite.play("big")
			else:
				sprite.texture = small_textures[texture_index-big_snowy_textures.size()]
				snow_sprite.play("small")
	

func _on_shake_area_area_entered(_area):
	_shake()


func _on_shake_area_area_exited(_area):
	_shake()

func _on_shake_timeout():
	sprite.material.set_shader_parameter("strength", 0)
	
