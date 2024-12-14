class_name DogPair extends Node2D

@onready var left_lead: Line2D = $LeftLead
@onready var left_dog: Dog = $LeftDog
@onready var right_lead: Line2D = $RightLead
@onready var right_dog: Dog = $RightDog

func _physics_process(_delta: float) -> void:
	left_lead.points[0] = left_dog.position
	right_lead.points[0] = right_dog.position
	
