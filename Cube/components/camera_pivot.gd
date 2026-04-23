extends Node3D

@export var sensitivity: float = 0.2
@export var min_distance: float = 0.0
@export var max_distance: float = 12.0
@export var zoom_speed: float = 1.0

var rot_x: float = 0.0
var rot_y: float = 0.0
var distance: float = 5.0

@onready var camera: Camera3D = $Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_update_camera()


func _input(event):
	if event is InputEventMouseMotion:
		rot_y -= event.relative.x * sensitivity
		rot_x -= event.relative.y * sensitivity
		rot_x = clamp(rot_x, -90, 90)
		_update_camera()

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance -= zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance += zoom_speed

		distance = clamp(distance, min_distance, max_distance)
		_update_camera()

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _update_camera():
	rotation_degrees = Vector3(rot_x, rot_y, 0)
	camera.position = Vector3(0, 0, distance)
