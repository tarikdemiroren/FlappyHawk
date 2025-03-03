extends Node2D

var area : Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = $BirdCatcher
	$Squeek.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x < -200:
		queue_free()


func _on_bird_catcher_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10)
