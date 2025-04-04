extends Control

func _on_2PJ_pressed() -> void:
	raiz.num_jugadores = 2
	setNombresJugadores()

func _on_3PJ_pressed() -> void:
	raiz.num_jugadores = 3
	setNombresJugadores()

func _on_4PJ_pressed() -> void:
	raiz.num_jugadores = 4
	setNombresJugadores()
	
func setNombresJugadores() -> void:
	#Contenedor con los nodos LineEdit
	var contenedor = get_node("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2")
	
	#Limpiar la lista de nombres y el contenedor
	get_node("PanelContainer/MarginContainer/VBoxContainer/Button").disabled = true
	raiz.nombres_jugadores.clear()
	if contenedor.get_child_count() > 0:  
		for child in contenedor.get_children(): 
			child.queue_free() 
	
	#Atributo style de los objetos LineEdit
	var style = StyleBoxFlat.new()
	style.bg_color = Color8(0, 120, 80)  #Color de la caja
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	
	#Para cada jugador
	for i in range(raiz.num_jugadores):
		#Se crea un nodo LineEdit
		var input_field = LineEdit.new() 
		#Nombre del nodo
		input_field.name = "NombreInput" + str(i+1) 
		#Se añade el nodo al contenedor
		contenedor.add_child(input_field) 
		
		#Se añade el atributo style (normal, seleccionado)
		input_field.add_theme_stylebox_override("normal", style)
		input_field.add_theme_stylebox_override("focus", style)
		
		#Texto en el recuadro antes de introducir un nombre
		input_field.alignment = HORIZONTAL_ALIGNMENT_CENTER
		input_field.placeholder_text = "Rata " + str(i+1)
		#Tamaño mínimo de cada hijo 
		input_field.custom_minimum_size = Vector2(150, 60)
		#Expandir horizontalmente para ocupar todo el contenedor
		input_field.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		#Llama a la función _name_entered() cuando se introduce un nombre
		input_field.text_submitted.connect(_name_entered)


func _name_entered(nombre: String) -> void:
	raiz.nombres_jugadores.append(nombre)
	
	if len(raiz.nombres_jugadores) == raiz.num_jugadores:
		get_node("PanelContainer/MarginContainer/VBoxContainer/Button").disabled = false


func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://intro.tscn")
