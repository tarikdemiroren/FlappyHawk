extends Node2D

var screen_width: int
var screen_height: int
var spawn_rate: float = 3.0
@export var enemy_scene: PackedScene
@onready var player = $Bird
@onready var scoreLabel = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	var timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.timeout.connect(spawn_enemy)
	add_child(timer)
	
	player.point_changed.connect(_on_score_changed)
	
	scoreLabel.text = "No Score!"

func spawn_enemy():
	var enemy_gap = 660  # Distance between enemies
	var min_y = 100  # Minimum Y position
	var max_y = screen_height - enemy_gap - 100  # Ensure space for second enemy

	# Randomly pick a Y position within bounds
	var enemy_y = randf_range(min_y, max_y)

	# Create enemy instance (contains both obstacles + area)
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = Vector2(screen_width, enemy_y)

	# Add enemy to the scene
	add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_changed(newScore):
	scoreLabel.text = "Score: " + str(newScore)
