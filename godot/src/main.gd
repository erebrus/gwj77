extends Node


@export var LevelScene: PackedScene

@export var pixel_per_meter := 32

@onready var timer = %TimerUi
@onready var distance_label = %DistanceLabel

var distance:float=0.0
var presents:int=0


func _ready() -> void:
	Events.obstacle_hit.connect(_on_obstacle_hit)
	Events.music_change_requested.connect(_on_music_change_requested)
	Events.present_captured.connect(_on_present_captured)
	
	var level = LevelScene.instantiate()
	level.ready.connect(_on_level_loaded)
	add_child(level)
	

func _on_level_loaded() -> void:
	timer.start()
	

func _on_present_captured():
	presents+=1
	Logger.info("Collected present.")
	

func _on_music_change_requested(id:Types.GameMusic):
	Globals.music_manager.change_game_music_to(id)
	

func _physics_process(_delta: float) -> void:
	distance = Globals.player.position.x / pixel_per_meter
	distance_label.text = "%d m" % (distance)
	

func _on_obstacle_hit() -> void:
	timer.stop()
	await get_tree().create_timer(1).timeout
	Globals.start_game()
	
