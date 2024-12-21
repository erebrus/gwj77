class_name BaseLevel extends Node2D

func _ready() -> void:
	_log_child_nodes()
	

func _log_child_nodes() -> void:
	Logger.debug("%s child nodes in base level" % get_child_count())
	get_tree().create_timer(5).timeout.connect(_log_child_nodes)
