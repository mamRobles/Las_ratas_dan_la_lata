extends Node2D

var jugadores : Array
const escena_jugador = preload("res://MINI3/Scenes/jugador-MINI3.tscn")
@onready var pos1 = $jugador1_pos.global_position
@onready var pos2 = $jugador2_pos.global_position
@onready var pos3 = $jugador3_pos.global_position
@onready var pos4 = $jugador4_pos.global_position
var posiciones : Array

var num_jugadores: int = 4

func add_player(indice):
	#instanciar escena jugador
	jugadores.append(escena_jugador.instantiate())
	var jugador = jugadores[-1]
	jugador.id = indice
	jugador.position = posiciones[indice]

	jugador.GIROIZQUIERDA = "ui_left{n}".format({"n":indice+1})
	jugador.GIRODERECHA = "ui_right{n}".format({"n":indice+1})
	jugador.AVANZAR = "ui_up{n}".format({"n":indice+1})
	jugador.RETROCEDER = "ui_down{n}".format({"n":indice+1})
	jugador.apply_scale(Vector2(0.5, 0.5))
	
	if indice % 2 == 0:
		jugador.rotate(deg_to_rad(180))
	
	add_child(jugador)


func _ready():
	posiciones  = [pos1,pos2,pos3,pos4]
	#for i in range(INICIO.num_jugadores):
	for i in range(num_jugadores):
		add_player(i)
