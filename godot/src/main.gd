extends Node


@onready var timer = %TimerUi

func _ready() -> void:
	timer.start()
	
	Events.obstacle_hit.connect(_on_obstacle_hit)
	
	if Globals.landscape:
		landscape()
	else:
		portrait()
	

func portrait() -> void:
	var stylebox: StyleBoxFlat = %ViewportBorder.get_theme_stylebox("panel")
	stylebox.border_width_top = 0
	stylebox.border_width_bottom = 0
	stylebox.border_width_left = 160
	stylebox.border_width_right = 160
	
	_set_node_process($PortraitLevel, true)
	_set_node_process($LandscapeBaseLevel, false)
	

func landscape() -> void:
	var stylebox: StyleBoxFlat = %ViewportBorder.get_theme_stylebox("panel")
	stylebox.border_width_top = 80
	stylebox.border_width_bottom = 80
	stylebox.border_width_left = 0
	stylebox.border_width_right = 0
	
	_set_node_process($PortraitLevel, false)
	_set_node_process($LandscapeBaseLevel, true)
	

func _set_node_process(node: Node, enabled: bool) -> void:
	node.visible = enabled
	
	if enabled:
		node.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		node.process_mode = Node.PROCESS_MODE_DISABLED
	

func _on_obstacle_hit() -> void:
	timer.stop()
	await get_tree().create_timer(1).timeout
	Globals.start_game()
	
