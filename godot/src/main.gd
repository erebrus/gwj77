extends Node


@export var pixel_per_meter := 32


@onready var timer = %TimerUi
@onready var distance_label = %DistanceLabel


func _ready() -> void:
	timer.start()
	
	Events.obstacle_hit.connect(_on_obstacle_hit)
	

func _physics_process(_delta: float) -> void:
	distance_label.text = "%d m" % (Globals.player.position.x / pixel_per_meter)
	

func _on_obstacle_hit() -> void:
	timer.stop()
	await get_tree().create_timer(1).timeout
	Globals.start_game()
	
