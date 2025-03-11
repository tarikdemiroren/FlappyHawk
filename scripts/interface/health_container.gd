extends Control

@export var max_health: int = 50
@onready var hearts_container = $HeartsContainer

const INITIAL_HEALTH: int = 20
const HEALTH_HEART_RATIO: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_health(INITIAL_HEALTH)

func update_health(health: int):
	print("Called update health with health: ", health)
	for i in range(hearts_container.get_child_count()):
		var heart = hearts_container.get_child(i)
		heart.visible = i <= (health / HEALTH_HEART_RATIO)
