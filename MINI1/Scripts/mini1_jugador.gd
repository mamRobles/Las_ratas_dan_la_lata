extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var areaColision = $Area2D # para interacción de jugadores entre sí
@onready var accion =1 # sirve para saber si la última tecla pulsada es derecha o izquierda
					   # y así definir la animación idle
@export var tiempodebuff = 1.0 #tiempo que dura el debuff, editable a la derecha
var debuff :float = 1.0 # variable debuff 
								#define cuánto se reduce la velocidad en el jugador
var debuffeado = false #define si estamos esperando que acabe el debuff o no
# TODO: estados de inmutabilidad posteriores al debuff, en los que no te pueden hacer eso otra vez
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#inputs según el id, se modifican en escenario según cuando se instancie
var izquierda="ui_left1"
var derecha ="ui_right1"
var arriba ="ui_up1"
var abajo = "ui_down1"

var escondido:bool = false
var muerto: bool =false
var id:int =1

func _ready() -> void:
	_animated_sprite.play("parado_derecha")
	areaColision.body_entered.connect(add_debuff)
	if INICIO.acc:
		$AnimatedSprite2D.material.set("shader_parameter/thickness",0.5)
		 
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.x = 0.0 # movimiento inicial es 0 hasta que se determine lo contrario abajo
	if not is_on_floor():
		velocity += get_gravity() * delta
	if muerto==false and MINI1.empezar:
		# Handle jump.
		if Input.is_action_just_pressed(arriba) and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis(izquierda, derecha)
		if direction:
			velocity.x = direction * SPEED *debuff
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func cambiar_color(indice):
	if INICIO.acc:
	##estos colores siguen la paleta de accesibilidad del color de IBM
		## apta para cualquier tipo de daltonismo
		## los html son:
		## #648FFF -> azul -> 0.392,0.561,1
		## #785EF0 -> morado -> 0.471,0.369,0.941
		## #DC267F -> magenta -> rgb01(0.863, 0.149, 0.498)
		## #FE6100 -> naranja -> rgb01(0.996, 0.38, 0)
		## #FFB000 - > amarillo -> rgb01(1, 0.69, 0)
		match indice:
			1:
				$AnimatedSprite2D.material.set("shader_parameter/outline_color", Color(0.863,0.149,0.498))
			2:
				$AnimatedSprite2D.material.set("shader_parameter/outline_color", Color(0.392,0.561,1.0))
			3:
				$AnimatedSprite2D.material.set("shader_parameter/outline_color", Color(1.0,0.69,0.0))
			4:
				$AnimatedSprite2D.material.set("shader_parameter/outline_color", Color(0.471,0.369,0.941))

func _process(_delta):
	if muerto:
		if accion==0:
			_animated_sprite.play("muerto_izquierda")
		else:
			_animated_sprite.play("muerto_derecha")
	elif MINI1.empezar:
		if Input.is_action_pressed(derecha):
			accion=1
			if escondido:
				_animated_sprite.play("derecha_escondido")
			else:
				_animated_sprite.play("derecha")
		else: if Input.is_action_pressed(izquierda):
			accion=0
			if escondido:
				_animated_sprite.play("izquierda_escondido")
			else:
				_animated_sprite.play("izquierda")
		else:
			if (accion):
				if escondido:
					_animated_sprite.play("parado_derecha_escondido")
				else:
					_animated_sprite.play("parado_derecha")
			else:
				if escondido:
					_animated_sprite.play("parado_izquierda_escondido")
				else:
					_animated_sprite.play("parado_izquierda")
					
func add_debuff(body):
	#si estamos debuff, da igual entrar aquí
	if debuffeado: return
	if body.get_class() == "CharacterBody2D":
		debuffeado =true
		debuff = 0.5
		await get_tree().create_timer(tiempodebuff).timeout
		debuff = 1.0
		debuffeado = false

	
