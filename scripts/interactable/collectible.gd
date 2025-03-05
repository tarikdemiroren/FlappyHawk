extends Node2D

@onready var coinSpawnSound = $CoinSpawn
@onready var coinPickSound = $CoinPick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coinSpawnSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_collection_area_body_entered(body: Node2D) -> void:
	if body.has_method("capture_coin"):
		body.capture_coin()
		coinPickSound.play()
	queue_free()
