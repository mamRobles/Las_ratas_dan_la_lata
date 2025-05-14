extends Node2D

var cerrar_ojos = "ui_down1"
var cabreado:bool = false
var usec=0.0
var nosfegatu_activo = false
var id = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cabreado==false:
		#Si no se ha cabreado por cerrar los ojos antes de tiempo
		if Input.is_action_just_pressed(cerrar_ojos):
			$AnimatedSprite2D.play("cerrarojos")
			if  nosfegatu_activo:
				usec =Time.get_ticks_usec()
			else:
				#si cerramos los ojos antes de tiempo el jugador se cabrea
				cabreado =true
				$AnimatedSprite2D.play("cabreado")
				await get_tree().create_timer(1).timeout
				cabreado =false
				$AnimatedSprite2D.play("default")
func _on_imagenmini_2_nosfegatu_aparece() -> void:
	nosfegatu_activo=true
