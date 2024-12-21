extends Node2D


func enter(sled: Sled) -> void:
	$sfx.play()
	sled.get_parent().crash()
	
