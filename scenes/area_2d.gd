extends Area2D
# recuperamos el jugador
@onready var player = $Player

func _ready():a
	# Asegúrate de que el área es invisible, solo con la colisión activa
	# Aquí no es necesario añadir un Sprite, solo la colisión es suficiente
	pass

# Detecta cuando un cuerpo entra en el área de la colisión
func _on_Area2D_body_entered(body):
	if body == player:
		print("El jugador tocó el límite")
