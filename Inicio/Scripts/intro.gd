extends Control

@onready var label: Label = $PanelContainer2/PanelContainer/MarginContainer/VBoxContainer/VBoxContainer2/Label

func _ready():
	label.text = "¡Van a jugar " + str(INICIO.num_jugadores) + " ratas!"
	INICIO.minijuegos.shuffle()
	#Contenedor vertical
	var contenedor = get_node("PanelContainer2/PanelContainer/MarginContainer/VBoxContainer")
	contenedor.add_theme_constant_override("separation", 15)
	
	#Atributo style de las etiquetas con los nombres
	var style = StyleBoxFlat.new()
	style.bg_color = Color8(6, 64, 82)  #Color de la caja
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
		
	#Para cada jugador
	for i in range(INICIO.num_jugadores):
		#Se crea un nodo Label
		var nombre = Label.new()
		#Nombre del nodo
		nombre.name = "NombreJugador" + str(i+1)
		#Texto de la Label
		nombre.text = INICIO.nombres_jugadores[i]
		var font = load("res://Sistema/ZCOOLKuaiLe-Regular.ttf")
		nombre.add_theme_font_override("font",font)
		nombre.add_theme_font_size_override("font_size", 28)
		#Se añade el nodo al contenedor
		contenedor.add_child(nombre)
		
		#Se añade el atributo style a la etiqueta
		nombre.add_theme_stylebox_override("normal", style)
		
		#Centrar el texto dentro de la Label
		nombre.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		nombre.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		#Tamaño mínimo de la Label
		nombre.custom_minimum_size = Vector2(150, 50)




func _on_jugar_pressed() -> void:
	#get_tree().change_scene_to_file("res://MINI1/Scenes/escenario-MINI1.tscn")
	get_tree().change_scene_to_file(INICIO.minijuegos.pop_front())
	#get_tree().change_scene_to_file("res://MINI3/Scenes/escenario-MINI3.tscn")
