extends CharacterBody2D

# Velocidades
var speed: float = 250  # Velocidad horizontal
var jump_force: float = -300  # Fuerza de salto (negativa porque hacia arriba)

# Variables de control de dirección
var direction: int = 1  # Dirección inicial: 1 = Derecha, -1 = Izquierda

# RayCast para detectar colisiones
@onready var raycast_derecha = $RayCast2Derecha
@onready var raycast_izquierda = $RayCast2Izquierda
@onready var raycast_arriba = $RayCast2Arriba

# Animaciones
@onready var sprite = $AnimatedSprite2D  # Acceso al nodo AnimatedSprite2D

# Gravedad
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Aplicar gravedad constantemente
	velocity.y += gravity * delta
	
	# Movimiento horizontal
	velocity.x = direction * speed
	
	
	# Detectar colisión con RayCasts
	if raycast_derecha.is_colliding() or raycast_izquierda.is_colliding():
		cambiar_direccion()
		saltar()
	
	if raycast_arriba.is_colliding():
		saltar()
	
	# Determinar la animación según el estado
	if velocity.x != 0:  # Si se está moviendo
		sprite.play("Run")
	else:  # Si está quieto
		sprite.play("Iddle")

	# Mover el cuerpo
	move_and_slide()

func cambiar_direccion():
	# Cambia la dirección del movimiento
	direction *= -1
	# Voltear el sprite horizontalmente
	sprite.flip_h = not sprite.flip_h

func saltar():
	# Aplica una fuerza de salto
	velocity.y = jump_force
