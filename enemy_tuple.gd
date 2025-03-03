extends Node2D

var speed: float = 200.0

@onready var scoreArea = $VBoxContainer/ScoreArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
