extends Node2D

@onready var spawnSound = $SpawnSound
@onready var pickupSound = $PickupSound
@onready var collectionArea = $CollectionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnSound.play()
	pickupSound.finished.connect(queue_free)
	
	var fadeTimer = Timer.new()
	add_child(fadeTimer)
	fadeTimer.start(4)
	fadeTimer.timeout.connect(start_fade)

func start_fade():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	for i in range(6):
		tween.tween_property(self, "modulate:a", 0.2, 0.1)
		tween.tween_property(self, "modulate:a", 1.0, 0.1)

	# Final fade-out to full transparency
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.finished.connect(queue_free)  # Remove the coin when fading is done

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.has_method("health_up"):
		body.health_up()
		pickupSound.play()
		collectionArea.set_deferred("monitoring", false)
		hide()
