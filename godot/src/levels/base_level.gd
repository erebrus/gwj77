extends Node2D

@export var TreeScene: PackedScene

func _ready() -> void:
	
	for i in range(-800, 2000, 20):
		_place_tree_around(Vector2(i, 160))
	

func _place_tree_around(at_position: Vector2) -> void:
	var tree = TreeScene.instantiate()
	var viewport_size = get_viewport().size
	tree.position.x = at_position.x + viewport_size.x 
	tree.position.y = at_position.y + randi_range(-viewport_size.y * 0.6, viewport_size.y * 0.6)
	add_child(tree)
	

func _on_place_tree_timer_timeout():
	_place_tree_around($Sled.position)
	
