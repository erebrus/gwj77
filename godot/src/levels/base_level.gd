extends Node2D

@export var TreeScene: PackedScene



func _on_place_tree_timer_timeout():
	var tree = TreeScene.instantiate()
	var viewport_size = get_viewport().size
	tree.position.x = $Sled.position.x + viewport_size.x 
	tree.position.y = $Sled.position.y + randi_range(-viewport_size.y * 0.6, viewport_size.y * 0.6)
	add_child(tree)
	
