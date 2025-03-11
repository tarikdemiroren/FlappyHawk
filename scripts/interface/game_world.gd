extends Node2D

var screen_width: int
var screen_height: int
var spawn_rate: float = 3.0
@export var enemy_scene: PackedScene
@export var coin_scene: PackedScene
@export var heart_scene: PackedScene
@onready var player = $Bird
@onready var scoreLabel = $Control/ScoreLabel
@onready var fadeScreen = $FadeOverlay
@onready var healthContainer = $HealthContainer
@onready var retryButton = $Control/ReturnButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.health_changed.connect(healthContainer.update_health)
	game_start()
	retryButton.hide()
	await fadeScreen.start_fade_out()
	fadeScreen.hide()
	player.on_death.connect(game_over)

	# Set up a periodic health check timer
	var health_check_timer = Timer.new()
	health_check_timer.wait_time = 5.0  # Check health every 1 second
	health_check_timer.autostart = true
	health_check_timer.timeout.connect(check_player_health)
	add_child(health_check_timer)

func game_start():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	var timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.timeout.connect(spawn_enemy)
	timer.timeout.connect(spawn_coin)
	add_child(timer)
	
	player.point_changed.connect(_on_score_changed)
	
	scoreLabel.text = "No Score!"

func game_over():
	# Move score label to the center of the screen
	var center_x = screen_width / 2 - scoreLabel.size.x / 2
	var center_y = screen_height / 2 - scoreLabel.size.y / 2
	scoreLabel.position = Vector2(center_x - 15, center_y)

	scoreLabel.add_theme_font_size_override("font_size", 100)  # Bigger text

	# Stop enemy spawning
	for child in get_children():
		if child is Timer:
			child.stop()  # Stop the spawn timer

	# Remove or hide all existing enemies
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()  # Deletes enemies safely
		
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.queue_free()
		
	for health_item in get_tree().get_nodes_in_group("health_items"):
		health_item.queue_free()

	retryButton.show()

	# Fade the screen
	fadeScreen.show()
	await fadeScreen.start_fade_in()

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
	enemy_instance.change_score_area() 
	enemy_instance.add_to_group("enemies")

func spawn_coin():
	if get_tree().get_nodes_in_group("coins").size() >= 4:
		return
	var coin_x = randf_range(50, screen_width-50)
	var coin_y = randf_range(30, screen_height-30)
	
	var coin_instance = coin_scene.instantiate()
	coin_instance.position = Vector2(coin_x, coin_y)
	add_child(coin_instance)
	coin_instance.add_to_group("coins")

# Periodically check player health and spawn health items if needed
func check_player_health():
	if player.health < 20 and get_tree().get_nodes_in_group("health_items").size() < 2:
		spawn_health_item()

# Spawn a health item at a random position on the screen
func spawn_health_item():
	var health_x = randf_range(50, screen_width - 50)
	var health_y = randf_range(30, screen_height - 30)
	
	var health_instance = heart_scene.instantiate()
	health_instance.position = Vector2(health_x, health_y)
	add_child(health_instance)
	health_instance.add_to_group("health_items")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_score_changed(newScore):
	scoreLabel.text = "Score: " + str(newScore)

func _retry_button_pressed() -> void:
	get_tree().reload_current_scene()
