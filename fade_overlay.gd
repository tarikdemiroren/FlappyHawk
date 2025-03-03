extends ColorRect

func start_fade():
	var tween = get_tree().create_tween()
	# Animate the shader parameter "circle_radius" from 0.0 to 1.5 over time
	tween.tween_property(self.material, "shader_parameter/circle_radius", 0.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished  # Wait until the tween finishes
	get_tree().quit()  # Quit after the effect is done
