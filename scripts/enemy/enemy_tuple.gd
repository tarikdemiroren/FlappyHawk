extends Node2D

var speed: float = 200.0
@export var score_area_height: float = 660.0  # Exported variable for height

@onready var scoreArea = $VBoxContainer/ScoreArea
@onready var scoreAreaShape = $VBoxContainer/ScoreArea/ScoreAreaShape
@onready var enemyBird = $VBoxContainer/EnemyBird
@onready var enemyBird2 = $VBoxContainer/EnemyBird2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		# Adjust the collision shape size
	if scoreAreaShape and scoreAreaShape.shape is RectangleShape2D:
		scoreAreaShape.shape.size.y = score_area_height  # Set height dynamically

	# Adjust the position of the lower enemy (EnemyBird2) based on the height of the score area
	enemyBird2.position.y = enemyBird.position.y + score_area_height  # Move it down
	
	scoreArea.body_entered.connect(_on_score_area_entered)
	scoreArea.body_exited.connect(_on_score_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta

func _on_score_area_entered(body: Node2D):
	if body.has_method("get_point"):
		body.get_point()  # Player gets a point
		
func _on_score_area_exited(body: Node2D):
	scoreArea.queue_free()
