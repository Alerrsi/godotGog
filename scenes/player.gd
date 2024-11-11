extends CharacterBody2D

var is_attacking = false
# verlocidad de personaje
var moveSpeed = 100
# velocidad de salto 
var jumpSpeed = 300
# lugar al cual mida el personaje
var faceSide = true
# valor de gravedad del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# animaciones del personaje
@onready var animations = $AnimatedSprite2D
# obtencion del tilemap
@onready var tilemap = $"../World/TileMap"
var dangerTile = 32




func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("attack") and velocity.x == 0 and not is_attacking:
		animations.play("attack")
		is_attacking = true

	# Control para desactivar el estado de ataque cuando la animación termina
	if is_attacking and not animations.is_playing():
		is_attacking = false
		animations.play("Idle")

	if not is_attacking:  # Solo se actualizan otras animaciones si no se está atacando
		updateAnimations()

	jump(delta)
	moveX()
	side()
	move_and_slide()
	
	move_and_slide()
	
	

func updateAnimations():
	if velocity.x and not is_attacking: 
		animations.play("Walk")
		
	elif not is_attacking:
		animations.play("Idle")
		
		
		
func moveX():
	var movement = Input.get_axis("move_left", "move_right")
	velocity.x = movement * moveSpeed
	
	
func side():
	if (faceSide and velocity.x < 0) or (not faceSide and velocity.x > 0):
		animations.flip_h = not animations.flip_h  # Invierte la dirección visual
		faceSide = not faceSide
		is_attacking = false
		
func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jumpSpeed
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
		
func die():
	print("¡El personaje ha muerto!")
	# Aquí podrías reiniciar la escena o eliminar al personaje
	get_tree().reload_current_scene()  # O cambiar de escena
	
# funcion que verifica la muerte del personaje
func check_for_danger():
	# Obtener la celda en la posición del jugador
	var tile_pos = tilemap.world_to_map(global_position)
	
	# Verificar si el tile en esa posición es el tile peligroso
	if tilemap.get_cellv(tile_pos) == dangerTile:
		die()  # Llamar a la función de muerte
		
	
