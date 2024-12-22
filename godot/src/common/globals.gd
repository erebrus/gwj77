extends Node

const GAME_SCENE_PATH = "res://src/main.tscn"
const START_SCENE_PATH = "res://src/start_screen/start_screen.tscn"

var master_volume:float = 100
var music_volume:float = 100
var sfx_volume:float = 100

const GameDataPath = "user://conf.cfg"
var config:ConfigFile

var in_game:=false
var in_dialogue:=false

var player: Player

@onready var music_manager: MusicManager = $MusicManager
@onready var upgrade_manager: UpgradeManager = $UpgradeManager


func _ready():
	_init_logger()
	Logger.info("Starting menu music")
	#music_manager.fade_in_menu_music()

	start_game(false)
	
func go_to_main_menu():
	get_tree().change_scene_to_file(START_SCENE_PATH)
	
	
func start_game(from_menu:=true):
	in_game=true

	if from_menu:
		music_manager.fade_menu_music()
		#await get_tree().create_timer(1).timeout
	music_manager.reset_synchronized_stream()
	upgrade_manager.init_list()
	if from_menu:
		get_tree().change_scene_to_file(GAME_SCENE_PATH)
		get_tree().paused = false
	music_manager.fade_in_game_music()
	

func start_screen():
	start_game()
	

func _init_logger():
	Logger.set_logger_level(Logger.LOG_LEVEL_INFO)
	Logger.set_logger_format(Logger.LOG_FORMAT_MORE)
	var console_appender:Appender = Logger.add_appender(ConsoleAppender.new())
	console_appender.logger_format=Logger.LOG_FORMAT_FULL
	console_appender.logger_level = Logger.LOG_LEVEL_INFO
	var file_appender:Appender = Logger.add_appender(FileAppender.new("res://debug.log"))
	file_appender.logger_format=Logger.LOG_FORMAT_FULL
	file_appender.logger_level = Logger.LOG_LEVEL_DEBUG
	Logger.info("Logger initialized.")
	

func do_lose():
	Events.game_over.emit()
	music_manager.fade_game_music(.5)
	await get_tree().create_timer(.5).timeout
	music_manager.fade_in_menu_music(.5)
	
	
	

func do_win():
	get_tree().quit()
