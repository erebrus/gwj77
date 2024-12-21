extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("default")
	
func _on_area_entered(_sled: Area2D) -> void:
	Events.present_captured.emit()
	queue_free()
