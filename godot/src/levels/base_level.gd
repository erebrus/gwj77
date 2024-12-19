extends Node2D

@export var TreeScene: PackedScene
@export var LogScene: PackedScene
@export var SnowPileScene: PackedScene
@export var MooseScene:PackedScene
@export var RabbitScene:PackedScene

func _ready() -> void:
	
	for i in range(-800, 2000, 20):
		if randf() < 0.5:
			_place_obstacle_around(SnowPileScene, Vector2(i, 160))
		if randf() < 0.7:
			_place_obstacle_around(TreeScene, Vector2(i, 160))
		else:
			_place_obstacle_around(LogScene, Vector2(i, 160))
	

func _place_obstacle_around(obstacle_scene: PackedScene, at_position: Vector2) -> void:
	var tree = obstacle_scene.instantiate()
	var viewport_size = get_viewport().size
	tree.position.x = at_position.x + viewport_size.x 
	tree.position.y = at_position.y + randi_range(-viewport_size.y * 0.6, viewport_size.y * 0.6)
	add_child(tree)
	

func _on_place_tree_timer_timeout():
	if randf() < 0.3:
		_place_obstacle_around(TreeScene, $Sled.position)
	else:
		_place_obstacle_around(LogScene, $Sled.position)
	
	
