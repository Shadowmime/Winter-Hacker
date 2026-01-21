extends CharacterBody2D

@export var move_speed: float = 1000.0

var target_position: Vector2
var moving := false

func _ready():
	target_position = global_position

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_position = get_global_mouse_position()
		moving = true

func _process(delta):
	if not moving:
		return

	var direction = target_position - global_position
	var distance = direction.length()

	if distance < 5.0:
		global_position = target_position
		moving = false
	else:
		global_position += direction.normalized() * move_speed * delta
