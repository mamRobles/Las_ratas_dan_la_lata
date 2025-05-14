extends Node2D

var cerrar_ojos = "ui_down1"
var cabreado:bool = false
var usec=0.0
var nosfegatu_activo = false
var id = 1
var asustado:bool =false
var cerrado_a_tiempo:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if asustado:
		$AnimatedSprite2D.play("asustado")
	else:
		if !cabreado and !cerrado_a_tiempo:
			#Si no se ha cabreado por cerrar los ojos antes de tiempo
			if Input.is_action_pressed(cerrar_ojos):
				$AnimatedSprite2D.play("cerrarojos")
				if  nosfegatu_activo:
					usec =Time.get_ticks_usec()
					cerrado_a_tiempo=true
				else:
					#si cerramos los ojos antes de tiempo el jugador se cabrea
					cabreado =true
					$AnimatedSprite2D.play("cabreado")
					await get_tree().create_timer(4).timeout
					cabreado =false
					$AnimatedSprite2D.play("default")
