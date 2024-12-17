extends Area2D

@export var next_scene_path: String

@onready var sprite = $Sprite2D 

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		sprite.visible = false  # Hide the key sprite
		get_tree().change_scene_to_file("res://scenes/Victoria.tscn")
