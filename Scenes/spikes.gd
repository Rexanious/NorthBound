extends Area2D

# The position where player respawns (set this in inspector)
@export var respawn_position: Vector2

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		body.global_position = respawn_position
		$"../../OuchSound".play()
	
