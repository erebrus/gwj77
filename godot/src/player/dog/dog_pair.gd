extends CharacterBody2D

@onready var lead: Line2D = $Lead
@onready var left_dog: AnimatedSprite2D = $LeftDog
@onready var right_dog: AnimatedSprite2D = $RightDog

func _physics_process(_delta: float) -> void:
	lead.points[0] = left_dog.position - Vector2(2,2)
	lead.points[2] = right_dog.position - Vector2(2,2)
	
