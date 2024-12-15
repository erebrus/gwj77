extends Node2D

@export var DogPairScene: PackedScene

@export var dog_pair_number: int = 4

@export var sled_distance:= 10.0
@export var distance:= 20.0

@export var turn_speed:= 40
@export var speed:= 200

var dog_pairs: Array[CharacterBody2D]
var is_alive:= false

@onready var lead: Line2D = $Lead
@onready var sled: Area2D = $Sled

func _ready() -> void:
	sled.area_entered.connect(_on_sled_area_entered)
	
	for i in dog_pair_number:
		_add_dog_pair(Vector2(-distance * i, 0))
	
	sled.position = Vector2(- sled_distance - distance * dog_pair_number, 4)
	lead.add_point(sled.position)
	
	is_alive = true
	

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	var target_positions: Array[Vector2]
	
	var input = Input.get_axis("move_left", "move_right")
	var velocity = Vector2(speed, input * turn_speed)
	target_positions.append(dog_pairs.front().global_position + delta * velocity)
	
	for i in dog_pair_number - 1:
		var current_position = dog_pairs[i + 1].global_position
		target_positions.append(_target_position(current_position, target_positions.back(), distance))
	
	target_positions.append(_target_position(sled.global_position, target_positions.back(), sled_distance))
	
	lead.clear_points()
	
	global_position = target_positions.front()
	lead.add_point(Vector2.ZERO)
	
	for i in dog_pair_number - 1:
		dog_pairs[i+1].global_position = target_positions[i+1]
		lead.add_point(target_positions[i+1] - global_position)
		
	
	sled.global_position = target_positions.back()
	lead.add_point(target_positions.back() - global_position)
	

func _target_position(current_position: Vector2, lead_position: Vector2, dist: float) -> Vector2:
	if current_position.distance_squared_to(lead_position) > pow(dist, 2):
		return lead_position + dist * lead_position.direction_to(current_position)
	else:
		return current_position
	

func _add_dog_pair(at_position: Vector2) -> void:
	var dogs = DogPairScene.instantiate()
	dogs.position = at_position
	add_child(dogs)
	dog_pairs.append(dogs)
	lead.add_point(at_position)
	

func _on_sled_area_entered(_area: Area2D) -> void:
	Events.obstacle_hit.emit()
	is_alive = false
