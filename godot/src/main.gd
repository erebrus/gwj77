extends Node


@export var LevelScene: PackedScene

@export var pixel_per_meter := 32

@onready var timer = %TimerUi
@onready var distance_label = %DistanceLabel
@onready var stamina_label: Label = %StaminaLabel

var distance:float=0.0
var presents:int=0


func _ready() -> void:
	Events.obstacle_hit.connect(_on_obstacle_hit)
	Events.music_change_requested.connect(_on_music_change_requested)
	Events.present_captured.connect(_on_present_captured)
	Events.stamina_changed.connect(_on_stamina_changed)
	Events.level_up.connect(_on_level_up)
	
	var level = LevelScene.instantiate()
	level.ready.connect(_on_level_loaded)
	add_child(level)
	

func _on_level_loaded() -> void:
	timer.start()
	

func _on_stamina_changed(value:float):
	stamina_label.text= "stamina: %d speed:%d" % [value, Globals.player.current_speed]
	

func _on_present_captured():
	presents+=1
	Logger.info("Collected present.")
	

func _on_music_change_requested(id:Types.GameMusic):
	Globals.music_manager.change_game_music_to(id)
	

func _physics_process(_delta: float) -> void:
	distance = Globals.player.position.x / pixel_per_meter
	distance_label.text = "%d m" % (distance)
	

func _on_obstacle_hit() -> void:
	if not timer.started:
		return
	
	timer.stop()
	await get_tree().create_timer(1).timeout
	Globals.start_game()
	

func _on_level_up() -> void:
	get_tree().paused = true
	
