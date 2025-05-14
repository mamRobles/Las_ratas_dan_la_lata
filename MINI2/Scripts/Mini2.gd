extends Node2D
signal hora_del_evento

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($"Imagen-mini2".sin_evento):
		$"Imagen-mini2".sin_evento=false
		#random entre 3 y 6
		var tiempo:int =(randi()%4)+4
		await get_tree().create_timer(tiempo).timeout
		hora_del_evento.emit()

#qué hacer cuando nosfegatu aparezca
func _on_imagenmini_2_nosfegatu_aparece() -> void:
	pass # Replace with function body.
