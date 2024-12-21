extends BaseLevel

@export_category("Scenes")
@export var TreeScene: PackedScene
@export var LogScene: PackedScene
@export var SnowPileScenes: Array[PackedScene]
@export var PresentScene: PackedScene

@export_category("Generation")
@export var grid_size:= 40
@export var screens_in_advance:= 1.5
@export var templates: Array[Texture2D]


var grid: Dictionary # Dictionary[Vector2, Node]



@onready var cells_per_screen = 640.0 / grid_size
@onready var cells_in_advance = screens_in_advance * cells_per_screen
@onready var checkpoint = -cells_in_advance


func _ready() -> void:
	super()
	while checkpoint < 0:
		_place_section()
	

func _physics_process(_delta: float) -> void:
	while $Sled.position.x > checkpoint * grid_size:
		_place_section()
	

func _place_section() -> void:
	var start_cell = Vector2(checkpoint + cells_in_advance, $Sled.position.y / grid_size)
	
	var template: Texture2D = templates.pick_random()
	var image: Image = template.get_image()
	var template_size = template.get_size()
	
	Logger.info("Placing section %s at %s" % [template.get_path().get_file(), start_cell])
	
	for x in template_size.x:
		for y in template_size.y:
			var pixel = image.get_pixel(x,y)
			var cell = start_cell + Vector2(0, - template_size.y / 2) + Vector2(x,y)
			Logger.debug("Processing cell at %s with color %s" % [cell, pixel])
			
			if randf() < pixel.g:
				_place_obstacle_on_cell(TreeScene, cell)
			else:
				if randf() < pixel.b:
					if randf() < 0.5:
						_place_obstacle_on_cell(SnowPileScenes.pick_random(), cell)
					else:
						_place_obstacle_on_cell(LogScene, cell)
				if randf() < pixel.r:
					_place_obstacle_on_cell(PresentScene, cell)
	
	checkpoint = start_cell.x + template_size.x - cells_in_advance
	
	

func _place_obstacle_on_cell(obstacle_scene: PackedScene, cell: Vector2) -> void:
	var obstacle = obstacle_scene.instantiate()
	var viewport_size = get_viewport().size
	var at_position = grid_size * cell
	obstacle.position.x = at_position.x + randi_range(- grid_size / 2, grid_size / 2)
	obstacle.position.y = at_position.y + randi_range(- grid_size / 2, grid_size / 2)
	add_child(obstacle)
	
