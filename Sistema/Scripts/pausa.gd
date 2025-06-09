extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Boton_pausa.material.set("shader_parameter/thickness",10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused==false:
			pausar()
		else:
			despausar()

func pausar()->void:
	$Boton_pausa.hide()
	get_tree().paused =true
	$Menu_Pausa.show()
	
func despausar()->void:
	$Menu_Pausa.hide()
	get_tree().paused=false
	$Boton_pausa.show()
	
func _on_boton_pausa_pressed() -> void:
	pausar()


func _on_volver_juego_pressed() -> void:
	despausar()
	
	

func _on_menu_principal_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDI.tscn")
	pass # Replace with function body.
