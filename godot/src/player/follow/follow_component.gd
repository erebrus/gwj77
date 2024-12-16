class_name FollowComponent extends Marker2D

@export var parent: Node2D
@export var jump_component: JumpComponent

var leader: DogPair:
	set(value):
		if value == leader:
			return
		leader = value
		leader.jump_component.jumped.connect(_on_leader_jumped)
	

var preparing_jump: bool
var jump_at: float


func at_distance(distance: float) -> void:
	var current_position = parent.global_position
	var leader_position = leader.global_position
	
	if current_position.distance_squared_to(leader_position) > pow(distance, 2):
		parent.global_position = leader_position + distance * leader_position.direction_to(current_position)
	
	if jump_component != null:
		if preparing_jump and parent.global_position.x > jump_at:
			preparing_jump = false
			jump_component.jump()
		
		leader.set_trailing_lead(global_position + Vector2(0, jump_component.height))
	else:
		leader.set_trailing_lead(global_position)
	

func _on_leader_jumped() -> void:
	preparing_jump = true
	jump_at = leader.global_position.x
