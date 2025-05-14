extends Control
signal nosfegatu_aparece #señal que llega al escenario
						# que dice que nosfegatu apareció
@export var sin_evento:bool =true

#si pasa demasiado tiempo sin aparecer nosfegatu, su probabilidad de
#aparecer se vuelve 100%, eso es la hora de la bestia
var hora_de_la_bestia :bool  =false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _evento(evento:String)->void:
	while (get_tree().paused==true):
		pass
	$AnimatedSprite2D.play("{n}".format({"n":evento}))
	await get_tree().create_timer(0.5).timeout
	var gatu:bool = randi()%2
	
	if(gatu or hora_de_la_bestia):
		#aparece nosfegatu
		$AnimatedSprite2D.play("{n}_si".format({"n":evento}))
		await get_tree().create_timer(0.5).timeout
		$nosfegatu.show()
		nosfegatu_aparece.emit()
	else:
		#no aparece nosfegatu, reproducimos la animación sin él
		$AnimatedSprite2D.play("{n}_no".format({"n":evento}))
		#esperamos un poquito, medio segundo
		await get_tree().create_timer(0.5).timeout
		# volvemos a la animación por dfecto
		$AnimatedSprite2D.play("default")
		#le decimos al Node2d que puede poner otro temporizador para los eventos
		sin_evento =true

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hora_de_la_bestia_timeout() -> void:
	hora_de_la_bestia=true

#cuando el temporziador del evento se lanza, se empieza un nuevo evento
func _on_node_2d_hora_del_evento() -> void:
	var evento_array: Array[String] = [ "puerta", "tumba", "atico","ventana" ]
	_evento(evento_array.pick_random())
	pass # Replace with function body.
