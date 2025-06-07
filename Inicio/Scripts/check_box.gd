extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	INICIO.save_acc_settings("altoContraste", toggled_on)
	
	if (toggled_on):
		INICIO.acc = "_a"
	else:
		INICIO.acc = ""
