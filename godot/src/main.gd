extends Node


@onready var timer = %TimerUi

func _ready() -> void:
	timer.start()
	
	Events.obstacle_hit.connect(_on_obstacle_hit)
	

func _on_obstacle_hit() -> void:
	timer.stop()
	await get_tree().create_timer(1).timeout
	Globals.start_game()
	
