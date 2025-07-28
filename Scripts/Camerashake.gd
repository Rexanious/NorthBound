extends PhantomCamera2D

func shake(strength: float, duration: float):
	var initial_offset = position
	var shake_tween = create_tween()
	
	# Random shake pattern
	for i in range(5):
		shake_tween.tween_property(self, "position", 
			initial_offset + Vector2(
				randf_range(-strength, strength),
				randf_range(-strength, strength)
			), 
			duration/10
		)
	
	shake_tween.tween_property(self, "position", initial_offset, duration/2)
