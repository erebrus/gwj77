@tool
class_name ObstacleComponent extends Area2D

@export var is_jumpable: bool = false
@export var height: float = 50:
	set(value):
		height = value
		queue_redraw()

@export var parent: Node2D


var areas_in_obstacle: Array[Area2D]


func _draw() -> void:
	if Engine.is_editor_hint() and is_jumpable:
		draw_line(Vector2.ZERO, Vector2(0, -height), Color.RED, 2)
	

func _physics_process(_delta) -> void:
	var areas = get_overlapping_areas()
	for area in areas:
		if hits(area):
			if not areas_in_obstacle.has(area):
				Logger.info("Entered obstacle at height: %s" % -area.jump_component.height)
				enter(area)
		else:
			if areas_in_obstacle.has(area):
				Logger.info("Exited obstacle at height: %s" % -area.jump_component.height)
				exit(area)
	

func hits(area: Area2D) -> bool:
	if area.get("jump_component") == null:
		return true
	else:
		return not is_jumpable or -area.jump_component.height <= height


func enter(area: Area2D) -> void:
	areas_in_obstacle.append(area)
	parent.enter(area)
	

func exit(area: Area2D) -> void:
	areas_in_obstacle.erase(area)
	if parent.has_method("exit"):
		parent.exit(area)
	

func _on_area_exited(area):
	if areas_in_obstacle.has(area):
		exit(area)
