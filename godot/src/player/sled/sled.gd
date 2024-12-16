class_name Sled extends Area2D


var follow_component: FollowComponent:
	get(): 
		if follow_component == null:
			follow_component = $FollowComponent
		return follow_component
	

var height: float:
	set(value):
		if value != height:
			height = value
			$JumpingBits.position.y = height
	
