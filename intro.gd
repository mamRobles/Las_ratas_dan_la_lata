extends Control

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer2/Label

func _ready():
	label.text = "¡Van a jugar " + str(raiz.num_jugadores) + " ratas!"
	
	#Contenedor vertical
	var contenedor = get_node("PanelContainer/MarginContainer/VBoxContainer")
	
	#Atributo style de las etiquetas con los nombres
	var style = StyleBoxFlat.new()
	style.bg_color = Color8(0, 120, 80)  #Color de la caja
	style.corner_radius_top_left = 10    #Redondear bordes
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
		
	#Para cada jugador
	for i in range(raiz.num_jugadores):
		#Se crea un nodo Label
		var nombre = Label.new() 
		#Nombre del nodo
		nombre.name = "NombreJugador" + str(i+1) 
		#Texto de la Label
		nombre.text = raiz.nombres_jugadores[i]
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
	get_tree().change_scene_to_file("res://escenario-MINI1.tscn")
