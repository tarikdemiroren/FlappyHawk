extends Control

@onready var startButton = $ButtonsContainer/StartButton
@onready var optionsButton = $ButtonsContainer/OptionsButton
@onready var exitButton = $ButtonsContainer/ExitButton
@onready var fadeOverlay = $FadeOverlay
@onready var optionsContainer = $OptionsContainer
@onready var buttonsContainer = $ButtonsContainer

@export var startScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startButton.pressed.connect(_on_start_pressed)
	optionsButton.pressed.connect(_on_options_pressed)
	exitButton.pressed.connect(_on_exit_pressed)
	
	fadeOverlay.hide()
	optionsContainer.hide()
	
	startScene = preload("res://scenes/interface/game_world.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed():
	fadeOverlay.show()
	await fadeOverlay.start_fade_in()
	get_tree().change_scene_to_packed(startScene)

func _on_options_pressed():
	buttonsContainer.hide()
	optionsContainer.show()
	
func _on_exit_pressed():
	fadeOverlay.show()
	await fadeOverlay.start_fade_in()
	get_tree().quit()  # Quit after the effect is done

func _on_check_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_spin_box_value_changed(value: float) -> void:
	GlobalVariables.speed = value


func _on_go_back_pressed() -> void:
	optionsContainer.hide()
	buttonsContainer.show()
