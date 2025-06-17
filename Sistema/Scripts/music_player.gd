extends AudioStreamPlayer

var musica_minijuegos = preload("res://Sistema/musica_minijuegos.mp3")
var musica_mdi = preload("res://Sistema/musica_mdi.mp3")
var musica_victoria =preload("res://Sistema/musica_victoria.wav")
var musica_mini1 = preload("res://Sistema/musica_mini1.mp3")
var musica_mini2 = preload("res://Sistema/musica_mini2.wav")
var musica_mini3 = preload("res://Sistema/musica_mini3.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func cambiarMusica(tipo:String):
	match tipo:
		"mdi":
			stop()
			stream = musica_mdi
			play()
		"minijuegos":
			stop()
			stream = musica_minijuegos
			play()
		"victoria":
			stop()
			stream = musica_victoria
			play()
		"mini1":
			stop()
			stream = musica_mini1
			play()
		"mini2":
			stop()
			stream = musica_mini2
			play()
		"mini3":
			stop()
			stream = musica_mini3
			play()
	pass
