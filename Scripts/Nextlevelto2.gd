extends Area2D

@export var next_scene: PackedScene  
@onready var animation_player = $"../../../AnimationPlayer"
@onready var camera = $PhantomCamera2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# 1. Play the animation (e.g., doors closing)
		animation_player.play("glass_closing")
		
		# 2. Tween the camera upward (like elevator moving)
		var tween = create_tween()
		tween.tween_property(camera, "position:y", camera.position.y - 500, 2.0).set_ease(Tween.EASE_OUT)
		
		# 3. Wait for BOTH to finish
		await animation_player.animation_finished
		await tween.finished
		get_tree().change_scene_to_packed(next_scene)
