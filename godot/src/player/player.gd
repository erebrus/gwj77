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
	_add_dog_pair(Vector2(sled_distance, 0))
	sled.follow_component.leader = dog_pairs[0]
	
	for i in range(1, dog_pair_number):
		_add_dog_pair(Vector2(sled_distance + i * distance, 0))
		dog_pairs[i-1].follow_component.leader = dog_pairs[i]
		
	
	is_alive = true
	

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	sled.follow_component.at_distance(sled_distance)
	for i in dog_pair_number - 1:
		dog_pairs[i].follow_component.at_distance(distance)
		
	var input = Input.get_axis("move_left", "move_right")
	var velocity = Vector2(speed, input * turn_speed)
	dog_pairs.back().position += delta * velocity
	
	_recalibrate_positions()
	
	if Input.is_action_just_pressed("jump"):
		dog_pairs.back().jump_component.jump()
	

func crash() -> void:
	Events.obstacle_hit.emit()
	is_alive = false
	

func modify_speed(factor) -> void:
	speed *= factor
	turn_speed *= factor
	

func _recalibrate_positions() -> void:
	var sled_offset = sled.position
	global_position = sled.global_position
	sled.position = Vector2.ZERO
	
	for i in dog_pair_number:
		dog_pairs[i].position -= sled_offset
	

func _add_dog_pair(at_position: Vector2) -> void:
	var dogs = DogPairScene.instantiate()
	dogs.position = at_position
	add_child(dogs)
	dog_pairs.append(dogs)
	
