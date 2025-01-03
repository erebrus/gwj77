class_name DogPair extends Area2D


var height: float:
	set(value):
		if value != height:
			height = value
			if is_node_ready():
				lead.points[1].y = follow_component.position.y + height
				lead_to_back.points[0].y = follow_component.position.y + height
				left_dog.height = height
				right_dog.height = height
	

@onready var lead: Line2D = $Lead
@onready var lead_to_back: Line2D = $LeadToBack
@onready var left_dog: Dog = $LeftDog
@onready var right_dog: Dog = $RightDog

@onready var jump_component = $JumpComponent

var follow_component: FollowComponent:
	get(): 
		if follow_component == null:
			follow_component = $FollowComponent
		return follow_component
	

func _ready() -> void:
	lead.points[1] = follow_component.position
	lead_to_back.points[0] = follow_component.position
	lead_to_back.points[1] = follow_component.position
	jump_component.jumped.connect(_on_jumped)
	jump_component.landed.connect(_on_landed)

func _on_jumped():
	left_dog.on_jumped()
	right_dog.on_jumped()
	$sfx_jump.play()
func _on_landed():
	left_dog.on_landed()
	right_dog.on_landed()
	$sfx_land.play()
	
func _physics_process(_delta: float) -> void:
	lead.points[0] = left_dog.lead_marker.global_position - global_position
	lead.points[2] = right_dog.lead_marker.global_position - global_position
	

func set_trailing_lead(other: Vector2) -> void:
	lead_to_back.points[1] = other - global_position
	
func on_speed_changed(new_speed:float):
	left_dog.on_speed_changed(new_speed)
	right_dog.on_speed_changed(new_speed)
