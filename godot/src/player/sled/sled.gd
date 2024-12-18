class_name Sled extends Area2D


@export var follow_component: FollowComponent
@export var jump_component: JumpComponent

@onready var snow_sprite: AnimatedSprite2D = $SnowSprite

var height: float:
	set(value):
		if value != height:
			height = value
			$JumpingBits.position.y = height
	
func _ready():
	snow_sprite.play("run")
