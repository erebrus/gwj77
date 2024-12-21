extends TextureProgressBar

func _ready() -> void:
	Events.stamina_changed.connect(_on_stamina_changed)
	Events.stamina_exhaustion_finished.connect(_on_stamina_exhaustion_finished)

func _on_stamina_changed(stamina:float) -> void:
	value = stamina
	if value > 0:
		tint_over.a = 0
	
	if value < 30:
		tint_progress = Color.CRIMSON
	elif value >= 30:
		tint_progress = Color.WHITE
	
	if stamina == 0:
		$AnimationPlayer.play("exhausted")

func _on_stamina_exhaustion_finished() -> void:
	$AnimationPlayer.stop()
	tint_over.a = 0
	
