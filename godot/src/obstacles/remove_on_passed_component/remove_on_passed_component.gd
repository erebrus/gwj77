extends Node2D

@export var check_interval:= 5.0
@export var offset:= 640


func _ready() -> void:
	get_tree().create_timer(check_interval).timeout.connect(_on_timeout)
	

func _on_timeout() -> void:
	if global_position.x < Globals.player.global_position.x - offset:
		get_owner().queue_free()
	else:
		get_tree().create_timer(check_interval).timeout.connect(_on_timeout)
