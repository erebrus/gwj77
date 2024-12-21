extends PanelContainer


@export var OptionScene: PackedScene


@onready var container: Container = %UpgradeContainer

func _ready() -> void:
	hide()
	Events.level_up.connect(_on_level_up)
	

func close() -> void:
	for child in container.get_children():
		child.queue_free()
	
	hide()
	get_tree().paused = false
	

func _on_level_up() -> void:
	get_tree().paused = true
	var options = Globals.upgrade_manager.get_random_available()
	if options.is_empty():
		close()
	else:
		for option in options:
			var scene = OptionScene.instantiate()
			scene.upgrade = option
			scene.selected.connect(_on_selected)
			container.add_child(scene)
		show()
	

func _on_selected() -> void:
	close()
