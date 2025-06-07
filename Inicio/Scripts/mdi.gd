extends MarginContainer
@export var audio_bus_name := "Master"

@onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	var video_settings = INICIO.load_video_settings()
	if video_settings["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	var audio_settings = INICIO.load_audio_settings()
	AudioServer.set_bus_volume_db(_bus, linear_to_db(audio_settings["master_volume"]))
	var acc_settings = INICIO.load_acc_settings()
	# daltonismo
	#alto contraste
	if acc_settings["altoContraste"]:
		INICIO.acc="_a"
func _on_jugarboton_pressed() -> void:
	print("Botón jugar")
	# cambiar a juego
	get_tree().change_scene_to_file("res://Inicio/Scenes/SCJ.tscn")
	pass # Replace with function body.


func _on_opciones_boton_pressed() -> void:
	print("Botón opciones")
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDO.tscn")
	pass # Replace with function body.


func _on_salirboton_pressed() -> void:
	#get_tree().quit(0)
	INICIO.salir_juego(0)
