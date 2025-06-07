extends Control
@onready var fullscreen = $MarginContainer/VBoxContainer/HBoxContainer2/fullscreen
@onready var volumen = $MarginContainer/VBoxContainer/HBoxContainer/Volumen
@onready var acc = $MarginContainer/VBoxContainer/HBoxContainer3/CheckBox
func _ready() -> void:
	var video_settings = INICIO.load_video_settings()
	fullscreen.button_pressed=video_settings.fullscreen
	var audio_settings = INICIO.load_audio_settings()
	volumen.value = audio_settings.master_volume
	var acc_settings = INICIO.load_acc_settings()
	acc.button_pressed=acc_settings.altoContraste
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDI.tscn")
	pass # Replace with function body.



func _on_volumen_drag_ended(value_changed: bool) -> void:
	if (value_changed):
		INICIO.save_audio_settings("master_volume", $MarginContainer/VBoxContainer/HBoxContainer/Volumen.value)
	pass # Replace with function body.
