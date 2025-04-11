extends Node2D

#Escondites
var esc1_scene = preload("res://scenes/libros-MINI1.tscn")
var esc2_scene = preload("res://scenes/planta-MINI1.tscn")
var esc3_scene = preload("res://scenes/jarron-MINI1.tscn")
var tipos_escondite := [esc1_scene, esc2_scene, esc3_scene]
var escondites : Array

#Variables
const CAM_START_POS := Vector2i(576, 324) #Posición inicial de la cámara
const BG_START_POS := Vector2i(576, 324)  #Posición inicial del fondo
const SPEED : float = 3.0				  #Velocidad del juego

var screen_size : Vector2i		#Tamaño de la ventana
var suelo_height : int			#Altura del suelo
var offset : int				#Desplazamiento de la cámara
var ultimo_escondite		
var escondido : bool = false


func _ready():
	screen_size = get_window().size
	suelo_height = $suelo.get_node("Sprite2D").texture.get_height()
	#reset()
	

func _process(delta):
	#Generar escondite
	generate_esc()
	
	#Mover la cámara, el fondo, el jugador e incrementar el offset
	$Camera2D.position.x += SPEED
	$Fondo.position.x += SPEED
	#$rata.position.x += SPEED
	offset += SPEED
	
	#Si la camara avanza mucho, mueve el suelo
	if $Camera2D.position.x - $suelo.position.x > screen_size.x * 1.5:
		$suelo.position.x += screen_size.x
	
	#Si el escondite desaparece de plano, lo elimina
	for esc in escondites:
		if esc.position.x < ($Camera2D.position.x - screen_size.x):
			remove_esc(esc)

#Resetear el offset y las posiciones de la cámara, el suelo y el fondo
#func reset():
	#offset = 0
	#$Camera2D.position = CAM_START_POS
	#$suelo.position = Vector2i(0,0)
	#$Fondo.position = BG_START_POS
	
#Generar escondite
func generate_esc():
	#Si la lista de escondites está vacía o el último escondite está a menos de X del borde izq
	if escondites.is_empty() or ultimo_escondite.position.x < offset + randi_range(200, 700):
		var tipo = tipos_escondite[randi() % tipos_escondite.size()]	#Tipo de escena (escondite)
		var esc
		esc = tipo.instantiate()	#Instancia de dicha escena
		
		#Altura del escondite
		var esc_height = esc.get_node("Sprite2D").texture.get_height()
		#Escala del escondite
		var esc_scale = esc.get_node("Sprite2D").scale
		#El escondite aparecerá en el extremo derecho de la pantalla más el offset
		#de ese instante más 100 (para que aparezca más allá del borde y no popee)
		var esc_x : int = screen_size.x + offset + 200
		#El escondite aparecerá a la altura de la pantalla menos la mitad de la altura del suelo 
		#menos la mitad de la altura del escondite más 30 (para profundidad)
		var esc_y : int = screen_size.y - (esc_height * esc_scale.y / 2) - (suelo_height / 2) + 30
		
		ultimo_escondite = esc		#Actualizar el último escondite
		add_esc(esc, esc_x, esc_y)  #Añadir escondite
		
#Añadir escondite
func add_esc(esc, x, y):
	esc.position = Vector2i(x, y)	#Define la posición del escondite 
	#Llamada a la función entrar_escondite() si un cuerpo entra en el área
	esc.body_entered.connect(entrar_escondite)
	#Llamada a la función salir_escondite() si un cuerpo sale del área
	esc.body_exited.connect(salir_escondite)
	#Añade la escena del escondite como un nodo hijo en el árbol
	add_child(esc)
	#Añade el escondite al array de escondites
	escondites.append(esc)

#Eliminar escondite
func remove_esc(esc):
	esc.queue_free()		#Eliminar el nodo del escondite
	escondites.erase(esc)	#Eliminar escena del array de escondites

#Si un body entra en el escondite
func entrar_escondite(body):
	if body.name == "MINI1_Jugador":		#Si es un jugador
		Mini1Jugador.escondido = true
		print("La rata esta escondida (rata cobarde)")

#Si un body sale del escondite
func salir_escondite(body):
	if body.name == "MINI1_Jugador":		#Si es un jugador
		Mini1Jugador.escondido  = false
		print("La rata ya NO esta escondida (ojala te coman)")
	
