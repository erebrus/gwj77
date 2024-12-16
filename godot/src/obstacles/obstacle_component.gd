@tool
class_name ObstacleComponent extends Area2D

@export var is_jumpable: bool = false
@export var height: float = 50:
	set(value):
		height = value
		queue_redraw()

@export var parent: Node2D


func _draw() -> void:
	if Engine.is_editor_hint() and is_jumpable:
		draw_line(Vector2.ZERO, Vector2(0, -height), Color.RED, 2)
	

func hits(target_height: float) -> bool:
	return not is_jumpable or -target_height <= height


func _on_area_entered(area: Area2D):
	if area.get("jump_component") != null:
		Logger.info("Hit obstacle at height: %s" % area.jump_component.height)
		if hits(area.jump_component.height):
			parent.enter(area)
	else:
		parent.enter(area)
	

func _on_area_exited(area):
	if parent.has_method("exit"):
		parent.exit(area)
