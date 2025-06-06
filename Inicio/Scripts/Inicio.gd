extends Node2D

var num_jugadores:int = 0
var nombres_jugadores = []
var config = ConfigFile.new()
const SETTINGS_FILE_PATH="user://settings.ini"
var minijuegos = ["res://MINI1/Scenes/escenario-MINI1.tscn","res://MINI2/Scenes/MINI2.tscn","res://MINI3/Scenes/escenario-MINI3.tscn"]
func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("keybindings","ui_right1", "D")
		config.set_value("keybindings","ui_right2", "Right")
		config.set_value("keybindings","ui_right3", "N")
		config.set_value("keybindings","ui_right4", "L")
		config.set_value("keybindings","ui_left1", "A")
		config.set_value("keybindings","ui_left2", "Left")
		config.set_value("keybindings","ui_left3", "V")
		config.set_value("keybindings","ui_left4", "J")
		config.set_value("keybindings","ui_up1", "W")
		config.set_value("keybindings","ui_up2", "Up")
		config.set_value("keybindings","ui_up3", "G")
		config.set_value("keybindings","ui_up4", "I")
		config.set_value("keybindings","ui_down1", "S")
		config.set_value("keybindings","ui_down1", "Down")
		config.set_value("keybindings","ui_down1", "B")
		config.set_value("keybindings","ui_down1", "K")
		config.set_value("keybindings","pause", "Escape")
		
		config.set_value("video", "fullscreen", false)
		
		config.set_value("audio","master_volume",1.0)
		config.save(SETTINGS_FILE_PATH)
		
	else:
		config.load(SETTINGS_FILE_PATH)
	pass
func save_video_settings(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_video_settings():
	var video_settings ={}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings ={}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func salir_juego(valor:int)->void:
	get_tree().quit(valor)

var puntos = [0, 0, 0, 0]
