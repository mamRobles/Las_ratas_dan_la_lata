extends Node2D
signal hora_del_evento

var ha_salido:bool = false #ha salido nosfegatu? para parar el process
@onready var pos1 = $jugador1_pos.global_position
@onready var pos2 = $jugador2_pos.global_position
@onready var pos3 = $jugador3_pos.global_position
@onready var pos4 = $jugador4_pos.global_position
const escena_jugador = preload("res://MINI2/Scenes/jugador-MINI2.tscn")
var posiciones : Array
var jugadores : Array
# Añadir un jugador al tree
func add_player(indice):
	#instanciar escena jugador
	jugadores.append(escena_jugador.instantiate())
		#usamos la variable jugador pa no escribir jugadores veintemilveces
	var jugador = jugadores[-1]
	# modificar posición, estética (gorritos), inputs
	jugador.position = posiciones.pop_back() # pposiciones de jugadores

	#TODO: añadir gorritos y colores y esas cosas
	jugador.id=indice
	jugador.cerrar_ojos="ui_down{n}".format({"n":indice+1})
	add_child(jugador)


func scare_player(indice):
	jugadores[indice].asustado=true
	MINI2.asustados[indice]=true
	#jugadores[indice].hide()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	posiciones  = [pos1,pos2,pos3,pos4]
	for i in range(INICIO.num_jugadores):
		add_player(i)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !ha_salido:
		if($"Imagen-mini2".sin_evento):
			$"Imagen-mini2".sin_evento=false
			#random entre 3 y 6
			var tiempo:int =(randi()%4)+4
			await get_tree().create_timer(tiempo).timeout
			hora_del_evento.emit()
	pass

#qué hacer cuando nosfegatu aparezca
func _on_imagenmini_2_nosfegatu_aparece() -> void:
	ha_salido=true
	for i in range(INICIO.num_jugadores):
		jugadores[i].nosfegatu_activo = true

	await get_tree().create_timer(0.5).timeout
	for i in range(INICIO.num_jugadores):
		if jugadores[i].usec == 0.0:
			scare_player(i)
	$mostrar_ganadores.start()


func _on_mostrar_ganadores_timeout() -> void:
	get_tree().change_scene_to_file("res://MINI2/Scenes/ganadores-MINI2.tscn")
