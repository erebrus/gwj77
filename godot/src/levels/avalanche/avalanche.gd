extends Node2D


@export var speed: float = 100


@onready var hitbox = $HitBox
@onready var sprite = $Parallax2D

func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_entered)
	

func _physics_process(delta: float) -> void:
	hitbox.global_position.y = Globals.player.global_position.y
	
	global_position.x += speed * delta
	

func _on_hitbox_entered(area: Area2D) -> void:
	if area is Sled:
		Globals.player.crash()
	
