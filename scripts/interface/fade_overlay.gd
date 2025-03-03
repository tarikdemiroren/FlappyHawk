extends ColorRect

func start_fade_in():
	self.material.set("shader_parameter/circle_radius", 1.0)
	var tween = get_tree().create_tween()
	# Animate the shader parameter "circle_radius" from 0.0 to 1.5 over time
	tween.tween_property(self.material, "shader_parameter/circle_radius", 0.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished  # Wait until the tween finishes

func start_fade_out():
	self.material.set("shader_parameter/circle_radius", 0.0)
	var tween = get_tree().create_tween()
	# Animate the shader parameter "circle_radius" from 0.0 to 1.5 over time
	tween.tween_property(self.material, "shader_parameter/circle_radius", 1.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished  # Wait until the tween finishes
