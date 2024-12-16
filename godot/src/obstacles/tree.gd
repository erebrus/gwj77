extends Node2D


func enter(sled: Sled) -> void:
	sled.get_parent().crash()
	
