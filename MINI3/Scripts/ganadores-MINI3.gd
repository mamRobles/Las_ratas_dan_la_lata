extends Control

func _ready() -> void:
	add_containers()

func add_containers() -> void:
	
	var h_contenedor = get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer")
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color8(0, 120, 80)  #Color de la caja
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	

	
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
		sprite.texture = load("res://MINI3/Sprites/cocheGanador-MINI3.png")
		sprite.set("size_flags_horizontal", Control.SIZE_SHRINK_CENTER)
		
		var puntos_suma = Label.new()
		puntos_suma.name = "PuntosSumaJugador" + str(i+1)
		puntos_suma.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puntos_suma.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		var puntos_total = Label.new()
		puntos_total.name = "PuntosTotalJugador" + str(i+1)
		puntos_total.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puntos_total.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		nombre.add_theme_stylebox_override("normal", style)
		puntos_suma.text = "+" + str(MINI3.puntos_MINI3[i]) + " pts"
		INICIO.puntos[i] += MINI3.puntos_MINI3[i]
		
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
		MusicPlayer.cambiarMusica("victoria")
		get_tree().change_scene_to_file("res://Final/Scenes/final.tscn")
