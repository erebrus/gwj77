extends TextureRect


func _ready() -> void:
	modulate.a = 0
	Events.music_change_requested.connect(_on_difficulty_changed)
	

func _on_difficulty_changed(difficulty: Types.GameMusic) -> void:
	visible = Globals.player.ui_avalanche_meter
		
	match difficulty:
		Types.GameMusic.EASY:
			$AnimationPlayer.play("easy")
		Types.GameMusic.NORMAL:
			$AnimationPlayer.play("normal")
		Types.GameMusic.HARD:
			$AnimationPlayer.play("hard")
	
