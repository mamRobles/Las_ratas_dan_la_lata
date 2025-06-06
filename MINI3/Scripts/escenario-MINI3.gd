extends Node2D

var jugadores : Array
const escena_jugador = preload("res://MINI3/Scenes/jugador-MINI3.tscn")
@onready var pos1 = $jugador1_pos.global_position
@onready var pos2 = $jugador2_pos.global_position
@onready var pos3 = $jugador3_pos.global_position
@onready var pos4 = $jugador4_pos.global_position
var posiciones : Array


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
	jugador.apply_scale(Vector2(0.3, 0.3))
	
	if indice == 0:
		$Label_jugador1.visible = true
		$Label_jugador1.text = INICIO.nombres_jugadores[indice]
		jugador.rotate(deg_to_rad(180))
	elif indice == 1:
		$Label_jugador2.visible = true
		$Label_jugador2.text = INICIO.nombres_jugadores[indice]
	elif indice == 2:
		$Label_jugador3.visible = true
		$Label_jugador3.text = INICIO.nombres_jugadores[indice]
		jugador.rotate(deg_to_rad(180))
	elif indice == 3:
		$Label_jugador4.visible = true
		$Label_jugador4.text = INICIO.nombres_jugadores[indice]
	
	add_child(jugador)


func _ready():
	posiciones  = [pos1,pos2,pos3,pos4]

	for i in range(INICIO.num_jugadores):
		add_player(i)
	
	$CuentaAtrasInicio.play("default")

func _process(delta: float) -> void:
	
	for i in range(INICIO.num_jugadores):
		var jugador = jugadores[i]
		
		if jugador.nivel == 1:
			jugador.puntos += delta * 1
		elif jugador.nivel == 2:
			jugador.puntos += delta * 5
		elif jugador.nivel == 3:
			jugador.puntos += delta * 10
	

func _on_puntos_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":		#Si es un jugador
		body.nivel += 1

func _on_puntos_body_exited(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":		#Si es un jugador
		body.nivel -= 1


func _on_inicio_timeout() -> void:
	MINI3.empezar = true
	$CuentaAtrasInicio.visible = false
	$Label_jugador1.visible = false
	$Label_jugador2.visible = false
	$Label_jugador3.visible = false
	$Label_jugador4.visible = false

func _on_fin_timeout() -> void:
	$MostrarGanadores.start()
	$CuentaAtrasFin.visible = true
	$CuentaAtrasFin.play("default")

func _on_mostrar_ganadores_timeout() -> void:
	for i in range(INICIO.num_jugadores):
		MINI3.puntos_MINI3[i] = int(jugadores[i].puntos / 10)
	get_tree().change_scene_to_file("res://MINI3/Scenes/ganadores-MINI3.tscn")
