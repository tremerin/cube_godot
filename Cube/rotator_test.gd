extends Node3D


var rotator: Area3D
var pieces: int = 5
var piece_size: float = 1
var cube_size: float
var offset: float
var piece = load("res://components/piece.tscn")
var can_move: bool = true


func _ready() -> void:
	cube_size = (pieces * 2) -1
	offset = (cube_size / 2) - (piece_size / 2)
	_create_test_rotator()
	_create_pieces(piece_size, pieces)


func _create_test_rotator() -> void:
	rotator = Area3D.new()
	var collision: CollisionShape3D = CollisionShape3D.new()
	var shape_box: BoxShape3D = BoxShape3D.new()
	shape_box.size = Vector3(cube_size, cube_size, cube_size)
	collision.shape = shape_box
	rotator.add_child(collision)
	rotator.collision_mask = 2
	add_child(rotator)


func _create_pieces(size: float, pieces: int) -> void:
	for x in range(pieces):
		for z in range(pieces):
			var instance = piece.instantiate()
			rotator.add_child(instance)
			instance.position = Vector3((x * piece_size * 2) - offset, 0, (z * piece_size * 2) - offset)


func _rotate_y(rotator: Area3D, positive: bool = true, time: float = 0.2) -> void:
	var distance: float = piece_size * 2
	var tween = create_tween()
	var new_position: Vector3
	for body in rotator.get_overlapping_bodies():
		if positive:
			if body.position.z == -offset and body.position.x != offset:
				new_position = body.position + Vector3.RIGHT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == offset and body.position.z != offset:
				new_position = body.position + Vector3.BACK * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == offset and body.position.x != -offset:
				new_position = body.position + Vector3.LEFT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == -offset and body.position.z != -offset:
				new_position = body.position + Vector3.FORWARD * distance
				tween.parallel().tween_property(body, "position", new_position, time)
		else:
			if body.position.x == -offset and body.position.z != offset:
				new_position = body.position + Vector3.BACK * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == offset and body.position.x != offset:
				new_position = body.position + Vector3.RIGHT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == offset and body.position.z != -offset:
				new_position = body.position + Vector3.FORWARD * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == -offset and body.position.x != -offset:
				new_position = body.position + Vector3.LEFT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
	tween.tween_callback(func(): can_move = true)


func _rotate_x(rotator: Area3D, positive: bool = true, time: float = 0.2) -> void:
	var distance: float = piece_size * 2
	var tween = create_tween()
	var new_position: Vector3
	for body in rotator.get_overlapping_bodies():
		if positive:
			if body.position.y == offset and body.position.z != offset:
				new_position = body.position + Vector3.BACK * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == offset and body.position.y != -offset:
				new_position = body.position + Vector3.DOWN * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.y == -offset and body.position.z != -offset:
				new_position = body.position + Vector3.FORWARD * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == -offset and body.position.y != offset:
				new_position = body.position + Vector3.UP * distance
				tween.parallel().tween_property(body, "position", new_position, time)
		else:
			if body.position.y == offset and body.position.z != -offset:
				new_position = body.position + Vector3.FORWARD * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == -offset and body.position.y != -offset:
				new_position = body.position + Vector3.DOWN * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.y == -offset and body.position.z != offset:
				new_position = body.position + Vector3.BACK * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.z == offset and body.position.y != offset:
				new_position = body.position + Vector3.UP * distance
				tween.parallel().tween_property(body, "position", new_position, time)
	tween.tween_callback(func(): can_move = true)


func _rotate_z(rotator: Area3D, positive: bool = true, time: float = 0.2) -> void:
	var distance: float = piece_size * 2
	var tween = create_tween()
	var new_position: Vector3
	for body in rotator.get_overlapping_bodies():
		if positive:
			if body.position.y == offset and body.position.x != offset:
				new_position = body.position + Vector3.RIGHT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == offset and body.position.y != -offset:
				new_position = body.position + Vector3.DOWN * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.y == -offset and body.position.x != -offset:
				new_position = body.position + Vector3.LEFT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == -offset and body.position.y != offset:
				new_position = body.position + Vector3.UP * distance
				tween.parallel().tween_property(body, "position", new_position, time)
		else:
			if body.position.y == offset and body.position.x != -offset:
				new_position = body.position + Vector3.LEFT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == -offset and body.position.y != -offset:
				new_position = body.position + Vector3.DOWN * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.y == -offset and body.position.x != offset:
				new_position = body.position + Vector3.RIGHT * distance
				tween.parallel().tween_property(body, "position", new_position, time)
			elif body.position.x == offset and body.position.y != offset:
				new_position = body.position + Vector3.UP * distance
				tween.parallel().tween_property(body, "position", new_position, time)
	tween.tween_callback(func(): can_move = true)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right") and can_move:
		can_move = false
		_rotate_z(rotator)
	if event.is_action_pressed("ui_left") and can_move:
		can_move = false
		_rotate_z(rotator, false)
