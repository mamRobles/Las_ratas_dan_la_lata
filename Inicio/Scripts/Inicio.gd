extends Node2D

var num_jugadores:int = 0
var nombres_jugadores = []

func salir_juego(valor:int)->void:
	get_tree().quit(valor)

var puntos = [0, 0, 0, 0]
