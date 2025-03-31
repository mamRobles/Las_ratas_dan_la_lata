extends MarginContainer


func _on_jugarboton_pressed() -> void:
	print("Botón jugar")
	# cambiar a juego
	get_tree().change_scene_to_file("res://primerNodo.tscn")
	pass # Replace with function body.


func _on_opciones_boton_pressed() -> void:
	print("Botón opciones")
	get_tree().change_scene_to_file("res://MDO.tscn")
	pass # Replace with function body.
