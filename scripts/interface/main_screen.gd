extends Control

@onready var startButton = $ButtonsContainer/StartButton
@onready var optionsButton = $ButtonsContainer/OptionsButton
@onready var exitButton = $ButtonsContainer/ExitButton
@onready var fadeOverlay = $FadeOverlay

@export var startScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startButton.pressed.connect(_on_start_pressed)
	optionsButton.pressed.connect(_on_options_pressed)
	exitButton.pressed.connect(_on_exit_pressed)
	
	fadeOverlay.hide()
	
	startScene = preload("res://scenes/interface/game_world.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed():
	fadeOverlay.show()
	await fadeOverlay.start_fade_in()
	get_tree().change_scene_to_packed(startScene)

func _on_options_pressed():
	pass
	
func _on_exit_pressed():
	fadeOverlay.show()
	await fadeOverlay.start_fade_in()
	get_tree().quit()  # Quit after the effect is done
