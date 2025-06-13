extends Control

func _ready():
	var contenedorV = get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer2")
	$PanelContainer2/PanelContainer/MarginContainer/AnimatedSprite2D.material.set("shader_parameter/thickness",2)
	#Atributo style de las etiquetas con los nombres
	var style = StyleBoxFlat.new()
	style.bg_color = Color8(0, 120, 80)  #Color de la caja
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	
	var puntos = INICIO.puntos.duplicate()
	var puntos_ordenados = puntos.duplicate()
	puntos_ordenados.sort()
	puntos_ordenados.reverse()
	var indices_ordenados = [0, 1, 2, 3]
	
	for i in range(INICIO.num_jugadores):
		indices_ordenados[i] = puntos.find(puntos_ordenados[i])
		puntos[indices_ordenados[i]] = -1
	
	var posiciones = [1, 1, 1, 1]
	
	for i in range(INICIO.num_jugadores-1):
		if INICIO.puntos[indices_ordenados[i]] > INICIO.puntos[indices_ordenados[i+1]]:
			for p in range(i+1, INICIO.num_jugadores):
				posiciones[p] += 1
	
	#Para cada jugador
	for i in range(INICIO.num_jugadores):
		var indice = indices_ordenados[i]
		var contenedorH = HBoxContainer.new()
		contenedorH.add_theme_constant_override("separation", 30)
		
		var sprite = TextureRect.new()
		sprite.name = "Posicion" + str(i+1)
		sprite.set("size_flags_horizontal", Control.SIZE_SHRINK_CENTER)
		var ruta = "res://Final/Sprites/" + str(posiciones[i]) + ".png"
		sprite.texture = load(ruta)
		contenedorH.add_child(sprite)
		
		#Se crea un nodo Label
		var nombre = Label.new()
		#Nombre del nodo
		nombre.name = "NombreJugador" + str(indice+1)
		#Texto de la Label
		nombre.text = INICIO.nombres_jugadores[indice]
		#Se añade el atributo style a la etiqueta
		nombre.add_theme_stylebox_override("normal", style)
		#Centrar el texto dentro de la Label
		nombre.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		nombre.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		#Tamaño mínimo de la Label
		nombre.custom_minimum_size = Vector2(150, 50)
		#Se añade el nodo al contenedor
		contenedorH.add_child(nombre)
		
		#Se crea un nodo Label
		var puntuacion = Label.new()
		#Nombre del nodo
		puntuacion.name = "PuntosJugador" + str(indice+1)
		#Texto de la Label
		puntuacion.text = str(INICIO.puntos[indice]) + " pts"
		#Se añade el atributo style a la etiqueta
		#puntuacion.add_theme_stylebox_override("normal", style)
		puntuacion.add_theme_font_size_override("Font Size", 100)
		puntuacion.add_theme_color_override("Font Color", Color8(0, 120, 80))
		#Centrar el texto dentro de la Label
		puntuacion.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puntuacion.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		#Tamaño mínimo de la Label
		puntuacion.custom_minimum_size = Vector2(50, 50)
		#Se añade el nodo al contenedor
		contenedorH.add_child(puntuacion)
		
		contenedorV.add_child(contenedorH)
		
		
		
		
func _on_volver_a_jugar_pressed() -> void:
	INICIO.minijuegos = ["res://MINI1/Scenes/escenario-MINI1.tscn","res://MINI2/Scenes/MINI2.tscn","res://MINI3/Scenes/escenario-MINI3.tscn"]
	INICIO.puntos = [0, 0, 0, 0]
	
	MINI1.empezar = false
	MINI1.muertos = [false, false, false, false]
	MINI2.asustados = [false, false, false, false]
	MINI3.puntos_MINI3 = [0, 0, 0, 0]
	MINI3.empezar = false
	MusicPlayer.cambiarMusica("mdi")
	
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDI.tscn")


func _on_salir_pressed() -> void:
	INICIO.salir_juego(0)
