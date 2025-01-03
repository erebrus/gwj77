extends Node2D


@export var speed: float = 110
@export var far_distance := 900.0
@export var critical_distance := 300.0

@onready var hitbox = $HitBox
@onready var sprite = $Parallax2D

var current:=Types.GameMusic.NORMAL

func _ready() -> void:
	hitbox.area_entered.connect(_on_hitbox_entered)
	Events.level_up.connect(_on_level_up)

func _on_level_up():
	speed+=11
	Logger.info ("avalanche speed: %d" % speed)
	if get_distance_to_player()>far_distance:
		global_position.x = Globals.player.global_position.x-far_distance
func _physics_process(delta: float) -> void:
	hitbox.global_position.y = Globals.player.global_position.y
	
	if not Debug.invulnerable: 
		global_position.x += speed * delta
	
	var new_category = get_distance_category()
	if new_category != current:
		current = new_category
		Events.music_change_requested.emit(current)

func _on_hitbox_entered(area: Area2D) -> void:
	if area is Sled:
		Globals.player.crash()
	

func get_distance_to_player()->float:
	return Globals.player.global_position.x - global_position.x

func get_distance_category():
	var d = get_distance_to_player()
	if d < critical_distance:
		return Types.GameMusic.HARD
	if d < far_distance:
		return Types.GameMusic.NORMAL
	return Types.GameMusic.EASY
	
func _on_log_timer_timeout() -> void:
	Logger.info("Avalanche distance: %d (%s)" % \
		[get_distance_to_player(), get_distance_category()])
