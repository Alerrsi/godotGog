extends CharacterBody2D


const SPEED = 100
var direccion = 1
@onready var ray_cast_2_derecha: RayCast2D = $RayCast2Derecha
@onready var ray_cast_2_izquierda: RayCast2D = $RayCast2Izquierda
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass
	

func _physics_process(delta):
	
	if not velocity.x:
		animated_sprite_2d.play("Walk")
		
	if not is_on_floor():
		print("flotando")
		velocity.y += gravity * delta
		
	if ray_cast_2_derecha.is_colliding():
		animated_sprite_2d.flip_h = true
		direccion = -1
	if ray_cast_2_izquierda.is_colliding():
		animated_sprite_2d.flip_h = false
		direccion = 1	
		
	position.x += direccion * SPEED * delta
	
	
	
	
	
