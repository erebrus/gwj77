extends VBoxContainer

@onready var progress: TextureProgressBar = $Progress


func _ready() -> void:
	progress.max_value = Globals.upgrade_manager.maximum_speed()
	

func update(speed: float) -> void:
	progress.value = speed
