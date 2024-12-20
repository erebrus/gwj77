extends Node2D

@export var textures: Array[Texture]


@onready var sprite := $Sprite2D

func _ready():
	sprite.texture = textures.pick_random()
	
	

func enter(sled: Sled) -> void:
	Logger.info("Entered snow pile")
	sled.get_parent().modify_current_speed(Types.PILE_SPEED_FACTOR)
	sled.get_parent().modify_acceleration(Types.PILE_ACCCEL_FACTOR)
	

func exit(sled: Sled) -> void:
	Logger.info("Exited snow pile")
	sled.get_parent().modify_acceleration(1/Types.PILE_ACCCEL_FACTOR)
	
