extends CharacterBody2D

@export var move_speed: float = 1000.0

# idk what this does
@onready var sprite: AnimatedSprite2D = $player

var target_position: Vector2
var moving := false
var last_facing := "front"

func _ready():
	target_position = global_position

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_position = get_global_mouse_position()
		moving = true

func _process(delta):
	if not moving:
		_play_if_needed(last_facing)
		return

	var direction = target_position - global_position
	var distance = direction.length()

	if distance < 5.0:
		global_position = target_position
		moving = false
	else:
		var dir_norm = direction.normalized()
		global_position += dir_norm * move_speed * delta
		_update_animation(dir_norm)


func _update_animation(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		if (dir.x > 0):
			last_facing = "right"
		else:
			last_facing = "left"
	else:
		if (dir.y > 0):
			last_facing = "front"
		else:
			last_facing = "back"
	_play_if_needed(last_facing)

func _play_if_needed(dir: String):
	if sprite.animation != dir:
		sprite.play(dir)
