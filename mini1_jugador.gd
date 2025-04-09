extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var accion =0 # sirve para saber si la última tecla pulsada es derecha o izquierda
					   # y así definir la animación idle
var escondido:bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	_animated_sprite.play("parado_derecha")
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("UI_izquierda", "UI_derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _process(_delta):
	if Input.is_action_pressed("UI_derecha"):
		accion=1
		if Mini1Jugador.escondido:
			_animated_sprite.play("derecha_escondido")
		else:
			_animated_sprite.play("derecha")
	else: if Input.is_action_pressed("UI_izquierda"):
		accion=0
		if Mini1Jugador.escondido:
			_animated_sprite.play("izquierda_escondido")
		else:
			_animated_sprite.play("izquierda")
	else:
		if (accion):
			if Mini1Jugador.escondido:
				_animated_sprite.play("parado_derecha_escondido")
			else:
				_animated_sprite.play("parado_derecha")
		else:
			if Mini1Jugador.escondido:
				_animated_sprite.play("parado_izquierda_escondido")
			else:
				_animated_sprite.play("parado_izquierda")
