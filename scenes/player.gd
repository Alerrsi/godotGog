extends CharacterBody2D

var is_attacking = false
var moveSpeed = 100
var jumpSpeed = 250
var faceSide = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animations = $AnimatedSprite2D
@onready var tilemap = $"../World/TileMap"
var dangerTile = 32
var is_dying = false  
func _ready() -> void:
	add_to_group("player")

@onready var attack_sound = $AudioStreamPlayer

func _physics_process(delta: float) -> void:
	if is_dying:
		return 

	if Input.is_action_just_pressed("attack") and velocity.x == 0 and not is_attacking:
		animations.play("attack")
		is_attacking = true
		attack_sound.play()  

	if is_attacking and not animations.is_playing():
		is_attacking = false
		animations.play("Idle")

	if not is_attacking:
		updateAnimations()

	jump(delta)
	moveX()
	side()
	move_and_slide()
	move_and_slide()

func updateAnimations():
	if velocity.x and not is_attacking and is_on_floor(): 
		animations.play("Walk")
	elif not is_attacking and is_on_floor():
		animations.play("Idle")

func moveX():
	var movement = Input.get_axis("move_left", "move_right")
	velocity.x = movement * moveSpeed

func side():
	if (faceSide and velocity.x < 0) or (not faceSide and velocity.x > 0):
		animations.flip_h = not animations.flip_h
		faceSide = not faceSide
		is_attacking = false

func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jumpSpeed
		animations.play("jump")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		animations.play("jump")

func die() -> void:
	
	is_dying = true  
	animations.play("die")
	animations.connect("animation_finished", Callable(self, "_on_die_animation_finished"))
	

func _on_die_animation_finished():
	# Disconnect the signal to avoid duplicate connections
	animations.disconnect("animation_finished", Callable(self, "_on_die_animation_finished"))
	
var boss_hit_count: int = 0

func _on_enemy_die_body_entered(body: Node2D) -> void:
	
	print(body.get_groups())
	if body.is_in_group("enemy"):
		
		body.queue_free()
	if body.is_in_group("boss"):
		boss_hit_count += 1  # Incrementar el contador
		print(boss_hit_count)
		
		# Verificar si se ha tocado 3 veces
		if boss_hit_count >= 3:
			body.queue_free()  # Eliminar al boss
			boss_hit_count = 0  # Reiniciar el contador (opcional)
