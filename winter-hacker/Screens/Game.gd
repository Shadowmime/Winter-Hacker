extends Node2D

@export var coldness_bar : ProgressBar
@export var player : CharacterBody2D

var coldness : float = 100:
	get:
		return coldness
	set(value):
		coldness = clamp(value, 0, 100)
		coldness_bar.value = value

var wolves := 0

var heating = false

func _ready() -> void:
	coldness_bar.max_value = coldness
	coldness_bar.value = coldness

func _process(delta: float) -> void:
	if !heating:
		coldness -= delta * 5
	else:
		coldness += delta * 5


func _on_computer_pressed() -> void:
	get_tree().change_scene_to_file("res://Screens/ComputerScreen.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		heating = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player: 
		heating = false
