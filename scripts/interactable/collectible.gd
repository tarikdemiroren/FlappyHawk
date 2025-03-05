extends Node2D

@onready var coinSpawnSound = $CoinSpawn
@onready var coinPickSound = $CoinPick
@onready var collectionArea = $CollectionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coinSpawnSound.play()
	coinPickSound.finished.connect(_on_coin_pick_sound_finished)  # Wait for sound to finish
	
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
	if body.has_method("capture_coin"):
		body.capture_coin()
		coinPickSound.play()
		collectionArea.set_deferred("monitoring", false)  # Disable further detection
		hide()  # Hide the entire coin node

func _on_coin_pick_sound_finished():
	queue_free()
