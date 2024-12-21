extends PanelContainer

signal selected


@export var margin = -10


var upgrade: Upgrade:
	set(value):
		upgrade = value
		%NameLabel.text = upgrade.name
		%DescriptionLabel.text = upgrade.description
	

var tween: Tween


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	pass


func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Globals.upgrade_manager.apply(upgrade)
		selected.emit()
