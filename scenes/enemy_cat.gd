extends CharacterBody2D

var speed = 100
var direccion = 1
@onready var ray_cast_2_derecha: RayCast2D = $RayCast2Derecha
@onready var ray_cast_2_izquierda: RayCast2D = $RayCast2Izquierda
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2_arriba: RayCast2D = $RayCast2Arriba
@onready var zona_muerte: Area2D = $zonaMuerte
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var death_sound: AudioStreamPlayer = $AudioStreamPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func _physics_process(delta):
	print("velocity.x: ", velocity.x)
	if not velocity.x:
		animated_sprite_2d.play("Walk")
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if ray_cast_2_derecha.is_colliding():
		animated_sprite_2d.flip_h = true
		direccion = -1
	if ray_cast_2_izquierda.is_colliding():
		animated_sprite_2d.flip_h = false
		direccion = 1	
		
	position.x += direccion * speed * delta

# Función para manejar la muerte del enemigo
func die():
	death_sound.play()  # Reproduce el sonido de muerte
	queue_free()  # Elimina al enemigo después de morir
