extends CharacterBody2D

var speed = 100
var direccion = 1
var fuerza_salto = -400  # Fuerza hacia arriba para el salto

@onready var ray_cast_2_derecha: RayCast2D = $RayCast2Derecha
@onready var ray_cast_2_izquierda: RayCast2D = $RayCast2Izquierda
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2_arriba: RayCast2D = $RayCast2Arriba
@onready var zona_muerte: Area2D = $zonaMuerte
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func _physics_process(delta):
	# Aplicar gravedad si no está en el suelo
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Movimiento horizontal
	position.x += direccion * speed * delta

	# Reproducir la animación de "Run"
	if not velocity.x:
		animated_sprite_2d.play("Run")
		
	# Detectar colisión con los RayCasts
	if ray_cast_2_derecha.is_colliding():
		animated_sprite_2d.flip_h = true
		direccion = -1
		realizar_salto()  # Saltar al colisionar a la derecha
		
	if ray_cast_2_izquierda.is_colliding():
		animated_sprite_2d.flip_h = false
		direccion = 1
		realizar_salto()  # Saltar al colisionar a la izquierda

	# Aplicar la velocidad calculada
	move_and_slide()

func realizar_salto():
	if is_on_floor():  # Solo saltar si está en el suelo
		velocity.y = fuerza_salto  # Aplicar fuerza de salto
		animated_sprite_2d.play("Jump")  # Opcional: reproducir animación de salto

# Función para manejar la muerte del enemigo
func die():
	queue_free()  # Elimina al enemigo después de morir
