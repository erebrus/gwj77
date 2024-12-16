class_name DogPair extends Node2D

@onready var lead: Line2D = $Lead
@onready var left_dog: AnimatedSprite2D = $LeftDog
@onready var right_dog: AnimatedSprite2D = $RightDog
@onready var lead_marker: Marker2D = $LeadPosition


func _ready() -> void:
	lead.points[1] = lead_marker.position
	

func _physics_process(_delta: float) -> void:
	lead.points[0] = left_dog.position - Vector2(2,2)
	lead.points[2] = right_dog.position - Vector2(2,2)
	

func follow_at_distance(lead: DogPair, distance: float) -> void:
	if global_position.distance_squared_to(lead.global_position) > pow(distance, 2):
		global_position = lead.global_position + distance * lead.global_position.direction_to(global_position)
	
