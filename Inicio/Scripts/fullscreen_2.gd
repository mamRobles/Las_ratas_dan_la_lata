extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	INICIO.save_video_settings("fullscreen", toggled_on)
	var mode := DisplayServer.window_get_mode()
	var is_window: bool = mode != DisplayServer.WINDOW_MODE_WINDOWED
	if (toggled_on):
		if !is_window:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		if is_window:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
