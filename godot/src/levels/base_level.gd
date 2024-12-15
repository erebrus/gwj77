extends Node2D

@export var TreeScene: PackedScene


func _ready() -> void:
	if not Globals.landscape:
		$Sled/Camera2D.make_current()
	

func _on_place_tree_timer_timeout():
	var tree = TreeScene.instantiate()
	var viewport_size = get_viewport().size
	tree.position.x = $Sled.position.x + randi_range(-viewport_size.x, viewport_size.x)
	tree.position.y = $Sled.position.y + viewport_size.y
	add_child(tree)
	
