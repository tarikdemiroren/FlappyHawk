extends Node2D

var screen_width: int
var screen_height: int
var spawn_rate: float = 3.0
@export var enemy_scene: PackedScene
@onready var player = $Bird
@onready var scoreLabel = $ScoreLabel
@onready var fadeScreen = $FadeOverlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_start()
	await fadeScreen.start_fade_out()
	fadeScreen.hide()

func game_start():
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
	var min_gap = 450  # Minimum distance between enemies
	var max_gap = 1000  # Maximum distance (for randomness)
	var enemy_gap = randf_range(min_gap, max_gap)  # Random height for variety

	var min_y = 100  
	var max_y = screen_height - enemy_gap - 100  

	# Randomly pick a Y position within bounds
	var enemy_y = randf_range(min_y, max_y)

	# Create enemy instance (contains both obstacles + area)
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = Vector2(screen_width, enemy_y)
	enemy_instance.score_area_height = enemy_gap  # Set dynamic score area height

	# Add enemy to the scene
	add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_changed(newScore):
	scoreLabel.text = "Score: " + str(newScore)
