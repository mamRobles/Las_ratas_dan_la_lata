extends CharacterBody2D

const VELOCIDAD = 100
const VELROT = 45

var GIROIZQUIERDA = "ui_left1"
var GIRODERECHA = "ui_right1"
var AVANZAR = "ui_up1"
var RETROCEDER = "ui_down1"

var id : int = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(AVANZAR) or Input.is_action_pressed(RETROCEDER):
		var diravance = - Input.get_axis(RETROCEDER, AVANZAR)
		var direccion = Vector2(cos(rotation), sin(rotation))
		move_and_collide(direccion * diravance * VELOCIDAD * delta)
		
		if Input.is_action_pressed(GIROIZQUIERDA) or Input.is_action_pressed(GIRODERECHA):
			var dirgiro = Input.get_axis(GIROIZQUIERDA, GIRODERECHA)
			rotate(deg_to_rad(dirgiro * delta * VELROT))
