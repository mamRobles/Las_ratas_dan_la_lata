extends Control

func _ready() -> void:
	add_containers()

func add_containers() -> void:
	
	var h_contenedor = get_node("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer")
	
	var style_vivo = StyleBoxFlat.new()
	style_vivo.bg_color = Color8(0, 120, 80)  #Color de la caja
	style_vivo.corner_radius_top_left = 10    #Redondear bordes
	style_vivo.corner_radius_top_right = 10
	style_vivo.corner_radius_bottom_left = 10
	style_vivo.corner_radius_bottom_right = 10
	
	var style_muerto = StyleBoxFlat.new()
	style_muerto.bg_color = Color8(0, 60, 40)  #Color de la caja
	style_muerto.corner_radius_top_left = 10    #Redondear bordes
	style_muerto.corner_radius_top_right = 10
	style_muerto.corner_radius_bottom_left = 10
	style_muerto.corner_radius_bottom_right = 10

	
	for i in range(INICIO.num_jugadores):
		var v_contenedor = VBoxContainer.new()
		#v_contenedor.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		v_contenedor.add_theme_constant_override("separation", 30)
		
		var nombre = Label.new()
		nombre.name = "NombreJugador" + str(i+1)
		nombre.text = INICIO.nombres_jugadores[i]
		nombre.custom_minimum_size = Vector2(150, 50)
		nombre.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		nombre.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		var sprite = TextureRect.new()
		sprite.name = "SpriteJugador" + str(i+1)
		
		var puntos_suma = Label.new()
		puntos_suma.name = "PuntosSumaJugador" + str(i+1)
		puntos_suma.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puntos_suma.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		var puntos_total = Label.new()
		puntos_total.name = "PuntosTotalJugador" + str(i+1)
		puntos_total.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puntos_total.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		if MINI1.muertos[i]:
			nombre.add_theme_stylebox_override("normal", style_muerto)
			sprite.texture = load("res://MINI1/Sprites/rata_muerta-MINI1.png")
			puntos_suma.text = "+0 pts"
		else:
			nombre.add_theme_stylebox_override("normal", style_vivo)
			sprite.texture = load("res://MINI1/Sprites/rata_viva-MINI1.png")
			puntos_suma.text = "+10 pts"
			INICIO.puntos[i] += 10
		
		puntos_total.text = str(INICIO.puntos[i])
		
		v_contenedor.add_child(nombre)
		v_contenedor.add_child(sprite)
		v_contenedor.add_child(puntos_suma)
		v_contenedor.add_child(puntos_total)
		
		h_contenedor.add_child(v_contenedor)

		

		

	


func _on_continuar_pressed() -> void:
	if !INICIO.minijuegos.is_empty():
		get_tree().change_scene_to_file(INICIO.minijuegos.pop_front())
	else:
		#TODO
		get_tree().change_scene_to_file("escena_ganadores")
