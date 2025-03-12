extends CharacterBody2D

var SPEED = 300.0
var JUMP_VELOCITY = -500.0
var BOOST_MULTIPLIER = 2.3
const BOOST_TIME = 0.2  # Time window for double-tap boost

@export var health = 20
@export var point = 0

var dieVar = false
var last_jump_time = 0.0
var can_boost = false
var last_direction = 1  # 1 = right, -1 = left
var double_point_active = false

@onready var shape: Sprite2D = $Birb
@onready var collision: CollisionShape2D = $BirdShape
@onready var scoreUpSound = $Scored
@onready var criticalSound = $CriticalHealthSound
@onready var double_point_timer = $DoublePointTimer

signal point_changed(new_point)
signal on_death()
signal health_changed(health)

func _ready() -> void:
	shape = $Birb
	collision = $BirdShape
	if GlobalVariables.speed != 0.0:
		SPEED = GlobalVariables.speed
	if GlobalVariables.jump_velocity != 0.0:
		JUMP_VELOCITY = GlobalVariables.jump_velocity
	if GlobalVariables.boost_multiplier != 0.0:
		BOOST_MULTIPLIER = GlobalVariables.boost_multiplier
		
	double_point_timer.timeout.connect(double_point_reset)

func double_point_reset():
	double_point_active = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta  # Gravity always applies

	# Handle horizontal movement
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		# Instantly change direction instead of gradually shifting
		if sign(velocity.x) != sign(direction):
			velocity.x = 0  # Reset velocity to prevent drift

		last_direction = direction

		# Only update velocity if it's not already exceeding the target speed
		if abs(velocity.x) < SPEED:
			velocity.x = move_toward(
				velocity.x, direction * SPEED, SPEED * (5 if abs(velocity.x) > SPEED * 0.5 else 7) * delta
			)
	else:
		var friction = SPEED * 2.5 * delta  # Increase this value for stronger friction
		velocity.x = move_toward(velocity.x, 0, friction) 
	# Handle jump and boost
	if Input.is_action_just_pressed("ui_accept") and not dieVar:
		var current_time = Time.get_ticks_msec() / 1000.0
		if can_boost and (current_time - last_jump_time <= BOOST_TIME):
			apply_boost()
		else:
			velocity.y = JUMP_VELOCITY
			can_boost = true  # Enable boost on next quick tap

		last_jump_time = current_time

	# Flip sprite based on direction
	if velocity.x != 0:
		shape.flip_h = velocity.x < 0

	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	var margin_x = 20
	var margin_y = 90
	
	global_position.x = clamp(global_position.x, -margin_x, screen_size.x + margin_x)
	global_position.y = clamp(global_position.y, -margin_y, screen_size.y + margin_y)

func apply_boost():
	velocity += Vector2(last_direction * SPEED * BOOST_MULTIPLIER, JUMP_VELOCITY * 0.5)
	can_boost = false  # Prevent multiple boosts
	double_point_active = true
	double_point_timer.start(0.5)

func take_damage(damage):
	health -= damage
	health_changed.emit(health)
	$Hurted.play()
	var tween = create_tween()
	tween.tween_property(shape, "modulate", Color(1, 0, 0), 0.1)
	tween.tween_property(shape, "modulate", Color(1, 1, 1), 0.1).set_delay(0.1)
	if health < 0:
		die()
	elif health < 10:
		criticalSound.play()

func die():
	shape.flip_v = true
	dieVar = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(0.5)
	on_death.emit()

func get_point():
	scoreUpSound.play()
	
	if double_point_active:
		point += 2
		print("Double Point")
	else:
		point += 1
	
	point_changed.emit(point)

func capture_coin():
	point += 10
	point_changed.emit(point)

func health_up():
	health += 10
	health_changed.emit(health)
