class_name DogPair extends Node2D

@onready var lead: Line2D = $Lead
@onready var lead_to_back: Line2D = $LeadToBack
@onready var left_dog: Dog = $LeftDog
@onready var right_dog: Dog = $RightDog
@onready var lead_marker: Marker2D = $LeadPosition


func _ready() -> void:
	lead.points[1] = lead_marker.position
	lead_to_back.points[0] = lead_marker.position
	lead_to_back.points[1] = lead_marker.position
	
	

func _physics_process(_delta: float) -> void:
	lead.points[0] = left_dog.lead_marker.global_position - global_position
	lead.points[2] = right_dog.lead_marker.global_position - global_position
	

func set_trailing_lead(other: Vector2) -> void:
	lead_to_back.points[1] = other - global_position
	

func follow_at_distance(lead: DogPair, distance: float) -> void:
	if global_position.distance_squared_to(lead.global_position) > pow(distance, 2):
		global_position = lead.global_position + distance * lead.global_position.direction_to(global_position)
	lead.set_trailing_lead(lead_marker.global_position)
