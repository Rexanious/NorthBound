extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("glass_moving")
	await get_tree().create_timer(3).timeout
	Dialogic.start("res://Level1timeline.dtl")
	$Elevator2/StaticBody2D/Sprite2D.position = Vector2(209, 140)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
