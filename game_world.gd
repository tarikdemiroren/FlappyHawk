extends Node2D

var screen_width: int
var screen_height: int
var spawn_rate: float = 3.0
@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	var timer = Timer.new()
	timer.wait_time = spawn_rate
	timer.autostart = true
	timer.timeout.connect(spawn_enemy)
	add_child(timer)

func spawn_enemy():
	var enemy_gap = 660  # Set the vertical distance between enemies
	var min_y = 100  # Minimum Y position
	var max_y = screen_height - enemy_gap - 100  # Ensure space for second enemy

	# Randomly pick a Y position within bounds
	var enemy1_y = randf_range(min_y, max_y)
	var enemy2_y = enemy1_y + enemy_gap  # Ensure fixed distance

	# Create enemy instances
	var enemy1 = enemy_scene.instantiate()
	var enemy2 = enemy_scene.instantiate()

	# Position enemies at the right edge with vertical spacing
	enemy1.position = Vector2(screen_width, enemy1_y)
	enemy2.position = Vector2(screen_width, enemy2_y)

	# Add enemies to the scene
	add_child(enemy1)
	add_child(enemy2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
