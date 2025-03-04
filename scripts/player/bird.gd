extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var shape : Sprite2D
var collision : CollisionShape2D
@export var health = 20
@export var point = 0
var dieVar : bool
var tween : Tween
@onready var scoreUpSound = $Scored
signal point_changed(new_point)
signal on_death()

func _ready() -> void:
	shape = $Birb
	collision = $BirdShape

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") && !dieVar:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction != 0 && !dieVar:
		shape.flip_h = direction < 0 

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func take_damage(damage):
	health -= damage
	$Hurted.play()
	tween = create_tween()
	tween.tween_property(shape, "modulate", Color(1, 0, 0), 0.1)  # Red tint
	tween.tween_property(shape, "modulate", Color(1, 1, 1), 0.1).set_delay(0.1)  # Back to normal
	if health < 0:
		die()

func die():
	shape.flip_v = true
	dieVar = true
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(0.5)  # Fade out before disappearing
	on_death.emit()
	
func get_point():
	scoreUpSound.play()
	point += 1
	point_changed.emit(point)
