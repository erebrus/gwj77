class_name Dog extends Node2D

@onready var lead_marker: Marker2D = %LeadMarker


var height: float:
	set(value):
		if value != height:
			height = value
			$AnimatedSprite.position.y = height
	
