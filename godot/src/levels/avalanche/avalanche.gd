extends Node2D


@export var speed: float = 100


@onready var hitbox = $HitBox
@onready var sprite = $Parallax2D
@onready var closing_in: Area2D = $ClosingIn
@onready var close: Area2D = $Close

func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_entered)
	

func _physics_process(delta: float) -> void:
	hitbox.global_position.y = Globals.player.global_position.y
	closing_in.global_position.y = Globals.player.global_position.y
	close.global_position.y = Globals.player.global_position.y
	
	
	global_position.x += speed * delta
	

func _on_hitbox_entered(area: Area2D) -> void:
	if area is Sled:
		Globals.player.crash()
	


func _on_close_area_entered(area: Area2D) -> void:
	Events.music_change_requested.emit(Types.GameMusic.HARD)


func _on_close_area_exited(area: Area2D) -> void:
	Events.music_change_requested.emit(Types.GameMusic.NORMAL)


func _on_closing_in_area_entered(area: Area2D) -> void:
	Events.music_change_requested.emit(Types.GameMusic.NORMAL)


func _on_closing_in_area_exited(area: Area2D) -> void:
	Events.music_change_requested.emit(Types.GameMusic.EASY)
