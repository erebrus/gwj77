@tool
extends Polygon2D

const CONTROL_POINT = 4.0 / 3 * tan(PI / (8))

@export var radius:= 10:
	set(value):
		if value != radius:
			radius = value
			_setup()
	

@export var depth:= 0.5:
	set(value):
		if value != depth:
			depth = value
			_setup()


func _setup() -> void:
	var height = radius * depth
	var curve := Curve2D.new()
	curve.bake_interval = 2
	
	curve.add_point(Vector2(0, height), Vector2.LEFT * CONTROL_POINT * radius, Vector2.RIGHT * CONTROL_POINT * radius)
	curve.add_point(Vector2(radius, 0), -Vector2.UP * CONTROL_POINT * height, -Vector2.DOWN * CONTROL_POINT * height)
	curve.add_point(Vector2(0, -height), -Vector2.LEFT * CONTROL_POINT * radius, -Vector2.RIGHT * CONTROL_POINT * radius)
	curve.add_point(Vector2(-radius, 0), Vector2.UP * CONTROL_POINT * height, Vector2.DOWN * CONTROL_POINT * height)
	curve.add_point(Vector2(0, height), Vector2.LEFT * CONTROL_POINT * radius, Vector2.RIGHT * CONTROL_POINT * radius)
	
	polygon = curve.get_baked_points()
