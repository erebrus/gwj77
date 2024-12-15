extends CharacterBody2D

@onready var left_lead: Line2D = $LeftLead
@onready var left_dog: AnimatedSprite2D = $LeftDog
@onready var right_lead: Line2D = $RightLead
@onready var right_dog: AnimatedSprite2D = $RightDog

func _physics_process(_delta: float) -> void:
	left_lead.points[0] = left_dog.position - Vector2(2,2)
	right_lead.points[0] = right_dog.position - Vector2(2,2)
	
