extends Node2D

@onready var coinSpawnSound = $CoinSpawn
@onready var coinPickSound = $CoinPick
@onready var collectionArea = $CollectionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coinSpawnSound.play()
	coinPickSound.finished.connect(_on_coin_pick_sound_finished)  # Wait for sound to finish

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
