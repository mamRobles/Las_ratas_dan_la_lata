extends CharacterBody2D

const VELOCIDAD = 200
const VELROT = 70
const EMPUJE = 5
const FRICCION = 50

var GIROIZQUIERDA = "ui_left1"
var GIRODERECHA = "ui_right1"
var AVANZAR = "ui_up1"
var RETROCEDER = "ui_down1"

var id : int = 1
var nivel : int = 0
var puntos : float = 0.0

var empuje_acumulado : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var diravance = - Input.get_axis(RETROCEDER, AVANZAR)
	var dirgiro = Input.get_axis(GIROIZQUIERDA, GIRODERECHA)
	
	if diravance != 0:
		rotate(deg_to_rad(dirgiro * delta * VELROT))
	
	var direccion = Vector2(cos(rotation), sin(rotation))
	velocity = direccion * diravance * VELOCIDAD + empuje_acumulado
	
	move_and_slide()
	empuje_acumulado = empuje_acumulado.move_toward(Vector2.ZERO, FRICCION * delta)
	

	for i in range(get_slide_collision_count()):
		var choque = get_slide_collision(i)
		var otroCoche = choque.get_collider()
		if otroCoche is CharacterBody2D:
			var empuje = (otroCoche.position - position).normalized() * EMPUJE
			otroCoche.chocado(empuje)


func chocado(empuje: Vector2) -> void:
	empuje_acumulado += empuje
			
