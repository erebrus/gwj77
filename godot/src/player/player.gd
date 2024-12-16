extends Node2D

@export var DogPairScene: PackedScene

@export var dog_pair_number: int = 4

@export var sled_distance:= 10.0
@export var distance:= 20.0

@export var turn_speed:= 40
@export var speed:= 100

var dog_pairs: Array[DogPair]
var is_alive:= false

@onready var sled: Area2D = $Sled


func _ready() -> void:
	sled.area_entered.connect(_on_sled_area_entered)
	
	_add_dog_pair(Vector2(sled_distance, 0))
	
	for i in range(1, dog_pair_number):
		_add_dog_pair(Vector2(sled_distance + i * distance, 0))
		
	is_alive = true
	

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	sled.position = _follow(sled.position, dog_pairs.front().position, sled_distance)
	
	for i in dog_pair_number - 1:
		dog_pairs[i].follow_at_distance(dog_pairs[i+1], distance)
		
	var input = Input.get_axis("move_left", "move_right")
	var velocity = Vector2(speed, input * turn_speed)
	dog_pairs.back().position += delta * velocity
	
	_recalibrate_positions()
	

func _follow(current_position: Vector2, lead_position: Vector2, dist: float) -> Vector2:
	if current_position.distance_squared_to(lead_position) > pow(dist, 2):
		return lead_position + dist * lead_position.direction_to(current_position)
	else:
		return current_position
	

func _recalibrate_positions() -> void:
	var sled_offset = sled.position
	global_position = sled.global_position
	sled.position = Vector2.ZERO
	
	for i in dog_pair_number:
		dog_pairs[i].position -= sled_offset
	
	dog_pairs.front().set_trailing_lead(sled.global_position)
	

func _add_dog_pair(at_position: Vector2) -> void:
	var dogs = DogPairScene.instantiate()
	dogs.position = at_position
	add_child(dogs)
	dog_pairs.append(dogs)
	

func _on_sled_area_entered(_area: Area2D) -> void:
	Events.obstacle_hit.emit()
	is_alive = false
