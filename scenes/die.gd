extends Area2D

	
@onready var sprite = $Sprite2D 
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"



func _on_body_entered(body: Node2D) -> void:
	var contador = 3;
	
	if body.is_in_group("player"):
		animated_sprite_2d.stop()
		print("hahahha")
				
				
			

		
