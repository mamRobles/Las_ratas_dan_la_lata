extends Node2D
#Jugadores
var jugadores : Array
const escena_jugador = preload("res://MINI1/Scenes/MINI1_jugador.tscn")
@onready var pos1 = $jugador1_pos.global_position
@onready var pos2 = $jugador2_pos.global_position
@onready var pos3 = $jugador3_pos.global_position
@onready var pos4 = $jugador4_pos.global_position
var posiciones : Array

var indices_aleatorios : Array

#Escondites
var esc1_scene = preload("res://MINI1/Scenes/libros-MINI1.tscn")
var esc2_scene = preload("res://MINI1/Scenes/planta-MINI1.tscn")
var esc3_scene = preload("res://MINI1/Scenes/jarron-MINI1.tscn")
var tipos_escondite := [esc1_scene, esc2_scene, esc3_scene]
var escondites : Array

#Meta
var meta_scene = preload("res://MINI1/Scenes/meta-MINI1.tscn")

#Variables
const CAM_START_POS := Vector2i(576, 324) #Posición inicial de la cámara
const BG_START_POS := Vector2i(576, 324)  #Posición inicial del fondo
const SPEED : float = 3.0				  #Velocidad del juego
#const FIN : float = 2.0

var screen_size : Vector2i		#Tamaño de la ventana
var suelo_height : int			#Altura del suelo
var offset : int				#Desplazamiento de la cámara
var ultimo_escondite		

var terminar : bool = false
var meta_generada : bool = false
var gato_activo : bool = false
var todos_muertos: bool
var meta

# Añadir un jugador al tree
func add_player(indice):
	#instanciar escena jugador
	jugadores.append(escena_jugador.instantiate())
		#usamos la variable jugador pa no escribir jugadores veintemilveces
	var jugador = jugadores[-1]
	jugador.id =indice
	# modificar posición, estética (gorritos), inputs
	###jugador.position = posiciones.pop_back() # pposiciones aleatorias de jugadores
	jugador.position = posiciones[indices_aleatorios[indice]]
	# # este código es para cuando no tienes lista aleatoria
	#if indice ==0:
	#	jugador.position=pos1
	#elif indice == 1:
	#	jugador.position=pos2
	#elif indice ==2:
	#	jugador.position=pos3
	#elif indice ==3:
	#	jugador.position=pos4
	#else:
	#	print("indice incorrecto")
	#TODO: añadir gorritos y colores y esas cosas
	jugador.izquierda="ui_left{n}".format({"n":indice+1})
	jugador.derecha="ui_right{n}".format({"n":indice+1})
	jugador.arriba="ui_up{n}".format({"n":indice+1})
	jugador.abajo="ui_down{n}".format({"n":indice+1})
	jugador.apply_scale(Vector2(4.0, 4.0))
	add_child(jugador)
	
	if indices_aleatorios[indice] == 0:
		$LabelPlayer1.text = INICIO.nombres_jugadores[indice]
		$LabelPlayer1.visible = true
	elif indices_aleatorios[indice] == 1:
		$LabelPlayer2.text = INICIO.nombres_jugadores[indice]
		$LabelPlayer2.visible = true
	elif indices_aleatorios[indice] == 2:
		$LabelPlayer3.text = INICIO.nombres_jugadores[indice]
		$LabelPlayer3.visible = true
	else:
		$LabelPlayer4.text = INICIO.nombres_jugadores[indice]
		$LabelPlayer4.visible = true


func kill_player(indice):
	jugadores[indice].muerto=true
	MINI1.muertos[indice]=true
	#jugadores[indice].hide()
	


func _ready():
	posiciones  = [pos1,pos2,pos3,pos4]
	###posiciones.shuffle() # aleatorizar lista de posiciones
	indices_aleatorios = [0, 1, 2, 3]
	indices_aleatorios.shuffle()
	for i in range(INICIO.num_jugadores):
		add_player(i)
	screen_size = get_window().size
	suelo_height = $suelo.get_node("Sprite2D").texture.get_height()
	$GatoAviso.visible = false
	$GatoAviso.play("default")
	$GatoCazando.visible = false
	$GatoCazando.play("default")
	$CuentaAtras.play("default")
	
	

func _process(_delta):
	if MINI1.empezar:
		if not todos_muertos:
			todos_muertos = true
			for i in range(INICIO.num_jugadores):
				if not MINI1.muertos[i]:
					todos_muertos = false
			if todos_muertos:
				$MostrarGanadores.start()
		
		if !terminar:
			if meta_generada:
				if meta.position.x == screen_size.x / 2 + offset:
						terminar = true
						$MostrarGanadores.start()
			else:
				#Generar escondite
				generate_esc()
			
			#Mover la cámara, el fondo, el jugador e incrementar el offset
			if !gato_activo:
				$Camera2D.position.x += SPEED
				$Fondo.position.x += SPEED
				$GatoAviso.position.x += SPEED
				$GatoCazando.position.x += SPEED
				$"../Pausa".position.x+=SPEED
				offset += SPEED
				$barrerainterdimensiona/CollisionShape2D.position.x+=SPEED
			
			#Si la camara avanza mucho, mueve el suelo
			if $Camera2D.position.x - $suelo.position.x > screen_size.x * 1.5:
				$suelo.position.x += screen_size.x
				$"CaídaAlVacío".position.x+=screen_size.x
				
			#Si el escondite desaparece de plano, lo elimina
			for esc in escondites:
				if esc.position.x < ($Camera2D.position.x - screen_size.x):
					remove_esc(esc)
			
			if gato_activo:
				for i in range(INICIO.num_jugadores):
					if jugadores[i].escondido ==false:
						kill_player(i)
						
	
#Generar escondite
func generate_esc():
	#Si la lista de escondites está vacía o el último escondite está a menos de X del borde izq
	if escondites.is_empty() or ultimo_escondite.position.x < offset + randi_range(200, 700):
		var tipo = tipos_escondite[randi() % tipos_escondite.size()]	#Tipo de escena (escondite)
		var esc
		esc = tipo.instantiate()	#Instancia de dicha escena
		
		#Altura del escondite
		var _esc_height = esc.get_node("Sprite2D").texture.get_height()
		#Escala del escondite
		var _esc_scale = esc.get_node("Sprite2D").scale
		#El escondite aparecerá en el extremo derecho de la pantalla más el offset
		#de ese instante más 100 (para que aparezca más allá del borde y no popee)
		var esc_x : int = screen_size.x + offset + 200
		#El escondite aparecerá a la altura de la pantalla menos la mitad de la altura del suelo 
		#menos la mitad de la altura del escondite más 30 (para profundidad)
		var esc_y : int =  pos1.y - (suelo_height/2)
		
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
	if body.get_class() == "CharacterBody2D":		#Si es un jugador
		body.escondido = true
		#print("La rata esta escondida (rata cobarde)")

#Si un body sale del escondite
func salir_escondite(body):
	if body.get_class() == "CharacterBody2D":		#Si es un jugador
		body.escondido  = false
		#print("La rata ya NO esta escondida (ojala te coman)")

func generate_fin():
	meta = meta_scene.instantiate()

	var _meta_height = meta.texture.get_height()
	var _meta_scale = meta.scale
	var meta_x : int = 2 * screen_size.x + offset
	var meta_y : int = pos1.y - (suelo_height / 2) 
	
	meta.position = Vector2i(meta_x, meta_y)
	add_child(meta)


func _on_fin_timeout() -> void:
	generate_fin()
	meta_generada = true
	
func _on_inicio_gato_timeout() -> void:
	$InicioGatoCazando.start()
	if !meta_generada:
		$GatoAviso.visible = true
		

func _on_inicio_gato_cazando_timeout() -> void:
	$FinGato.start()
	if !meta_generada:
		$GatoAviso.visible = false
		$GatoCazando.visible = true
		gato_activo = true

func _on_fin_gato_timeout() -> void:
	$GatoCazando.visible = false
	gato_activo = false
	
	
func _on_mostrar_ganadores_timeout() -> void:
	get_tree().change_scene_to_file("res://MINI1/Scenes/ganadores-MINI1.tscn")


func _on_inicio_timeout() -> void:
	MINI1.empezar = true
	$CuentaAtras.visible = false
	$LabelPlayer1.visible = false
	$LabelPlayer2.visible = false
	$LabelPlayer3.visible = false
	$LabelPlayer4.visible = false
	

func _on_caída_al_vacío_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":		#Si es un jugador
		if body.muerto ==false: kill_player(body.id) #matalo si no está muerto
		body.hide() # no se ve en la escena 
	
