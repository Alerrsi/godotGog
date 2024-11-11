extends CharacterBody2D

const PigRun = 120
const gravity = 98

var player = null


func _ready():
	
	velocity.x = PigRun
	$AnimatedSprite2D.play("Walk")

func _physics_process(delta):
	velocity.y += gravity
	player = get_tree().get_nodes_in_group("player")[0]
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall():
		# Invertir la dirección al chocar con una pared
		velocity.x = -velocity.x
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true 	
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		

	# Mover al personaje con la velocidad actualizada
	move_and_slide()
	
func follow():
	if player !=null:
		velocity = position.direction_to(player.position) * PigRun
