extends BaseLevel

@export_category("Scenes")
@export var TreeScene: PackedScene
@export var LogScene: PackedScene
@export var SnowPileScenes: Array[PackedScene]
@export var PresentScene: PackedScene
@export var SnowmanScene: PackedScene

@export_category("Generation")
@export var grid_size:= 32
@export var cells_between_log_and_snow:= 4
@export var screens_in_advance:= 1.5
@export var easy_templates: Array[Texture2D]
@export var normal_templates: Array[Texture2D]
@export var hard_templates: Array[Texture2D]
@export var start_template:Texture2D

@onready var cells_per_screen = 640.0 / grid_size
@onready var cells_in_advance = screens_in_advance * cells_per_screen
@onready var checkpoint = -cells_in_advance


var previous_obstacles: Dictionary # Dictionary[Vector2, Types.Obstacle]


func _ready() -> void:
	super()
	_place_section(start_template)
	while checkpoint < 0:
		_place_section()
	

func _physics_process(_delta: float) -> void:
	while $Sled.position.x > checkpoint * grid_size:
		_place_section()
	

func _easy_prob(level: int) -> float:
	if level > 10:
		return 0
	return 1 - level * 0.1
	

func _medium_prob(level: int) -> float:
	if level < 8:
		return 1
	return 1 - (level - 8) * 0.06
	

func _get_random_template() -> Texture2D:
	var level = get_parent().current_level
	
	if randf() < _easy_prob(level):
		return easy_templates.pick_random()
	
	if randf() < _medium_prob(level):
		return normal_templates.pick_random()
	
	return hard_templates.pick_random()
	

func _place_section(tex:Texture2D=null) -> void:
	var start_cell = Vector2(checkpoint + cells_in_advance, $Sled.position.y / grid_size)
	
	var template: Texture2D = tex if tex != null else _get_random_template()
	var image: Image = template.get_image()
	var template_size = template.get_size()
	var obstacles: Dictionary
	
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
					var rnd = randf()
					if  rnd < 0.4:
						if not _has_obstacle_in_range(Types.Obstacle.Log, cell, obstacles)\
							and not _has_obstacle_in_range(Types.Obstacle.Snowman, cell, obstacles):
								_place_obstacle_on_cell(SnowPileScenes.pick_random(), cell)
								obstacles[cell] = Types.Obstacle.Snowpile
					elif rnd <.9:
						if not _has_obstacle_in_range(Types.Obstacle.Snowpile, cell, obstacles)\
							and not _has_obstacle_in_range(Types.Obstacle.Snowman, cell, obstacles):
								_place_obstacle_on_cell(LogScene, cell)
								obstacles[cell] = Types.Obstacle.Log
					else:
						if not _has_obstacle_in_range(Types.Obstacle.Snowpile, cell, obstacles)\
							and not _has_obstacle_in_range(Types.Obstacle.Log, cell, obstacles):
								_place_obstacle_on_cell(SnowmanScene, cell)
								obstacles[cell] = Types.Obstacle.Log
						
				if randf() < pixel.r:
					_place_obstacle_on_cell(PresentScene, cell)
	
	previous_obstacles = obstacles
	checkpoint = start_cell.x + template_size.x - cells_in_advance
	

func _place_obstacle_on_cell(obstacle_scene: PackedScene, cell: Vector2) -> void:
	var obstacle = obstacle_scene.instantiate()
	var at_position = grid_size * cell
	@warning_ignore("integer_division")
	obstacle.position.x = at_position.x + randi_range(- grid_size / 2, grid_size / 2)
	@warning_ignore("integer_division")
	obstacle.position.y = at_position.y + randi_range(- grid_size / 2, grid_size / 2)
	add_child(obstacle)
	

func _has_obstacle_in_range(type: Types.Obstacle, cell: Vector2, obstacles: Dictionary) -> bool:
	for x in range(cell.x - cells_between_log_and_snow, cell.x):
		for y in range(cell.y - cells_between_log_and_snow, cell.y + cells_between_log_and_snow):
			var c = Vector2(x,y)
			if previous_obstacles.has(c) and previous_obstacles[c] == type:
				return true
	
	for x in range(cell.x - cells_between_log_and_snow, cell.x):
		for y in range(cell.y - cells_between_log_and_snow, cell.y + cells_between_log_and_snow):
			var c = Vector2(x,y)
			if obstacles.has(c) and obstacles[c] == type:
				return true
	
	return false
