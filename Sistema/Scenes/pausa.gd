extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boton_pausa_pressed() -> void:
	$Boton_pausa.hide()
	get_tree().paused =true
	$Menu_Pausa.show()


func _on_volver_juego_pressed() -> void:
	$Boton_pausa.show()
	$Menu_Pausa.hide()
	get_tree().paused=false
	pass # Replace with function body.
	

func _on_menu_principal_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDI.tscn")
	pass # Replace with function body.
