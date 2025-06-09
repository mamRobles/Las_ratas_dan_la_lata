extends Control

const MAX_LONGITUD_NOMBRES = 20

func _on_2PJ_pressed() -> void:
	INICIO.num_jugadores = 2
	setNombresJugadores()

func _on_3PJ_pressed() -> void:
	INICIO.num_jugadores = 3
	setNombresJugadores()

func _on_4PJ_pressed() -> void:
	INICIO.num_jugadores = 4
	setNombresJugadores()
	
func setNombresJugadores() -> void:
	#Contenedor con los nodos LineEdit
	var contenedor = get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2")
	
	#Limpiar la lista de nombres y el contenedor
	get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/Button").disabled = true
	INICIO.nombres_jugadores.clear()
	if contenedor.get_child_count() > 0:  
		for child in contenedor.get_children(): 
			child.queue_free() 
	
	#Atributo style de los objetos LineEdit
	var style = StyleBoxFlat.new()
	if INICIO.num_jugadores==4:
		style.bg_color = Color8(0, 119, 133)  #Color de la caja
	elif INICIO.num_jugadores==3:
		style.bg_color = Color8(171, 121, 0)  #Color de la caja
	elif INICIO.num_jugadores==2:
		style.bg_color = Color8(164, 95, 0)
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10

	#Para cada jugador
	for i in range(INICIO.num_jugadores):
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
		input_field.text_changed.connect(_name_entered.bind(i))


func _name_entered(nombre: String, indice: int) -> void:
	if nombre.length() > MAX_LONGITUD_NOMBRES:
		nombre = nombre.substr(0, MAX_LONGITUD_NOMBRES-3) + "..."
	if INICIO.nombres_jugadores.is_empty() or INICIO.nombres_jugadores.size()<INICIO.num_jugadores:
		for i in INICIO.num_jugadores:
			INICIO.nombres_jugadores.append("")
	INICIO.nombres_jugadores.set(indice, nombre)
	if !INICIO.setNombres_jugadores[indice]:
		INICIO.setNombres_jugadores[indice] =true
		INICIO.nombresPuestos+=1
		
	if INICIO.nombresPuestos == INICIO.num_jugadores:
		get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/Button").disabled = false


func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/Scenes/intro.tscn")
