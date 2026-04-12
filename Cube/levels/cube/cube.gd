extends Node3D

@onready var rotators_x: Node3D = $RotatorsX
@onready var rotators_y: Node3D = $RotatorsY
@onready var rotators_z: Node3D = $RotatorsZ
@onready var containers: Node3D = $Containers

var line_length: int = 4
var container_size: float = 1.0
var cube_size: float = (line_length * (container_size * 2)) - container_size
var offset: float = cube_size/2 - container_size/2
var can_move: bool = true
var piece = load("res://components/piece.tscn")


func _ready() -> void:
	print("line length: ", line_length)
	print("cube_size: ", cube_size)
	print("offset: ", offset)
	_create_rotators(line_length)
	_create_containers(line_length)
	_cube_box(cube_size)
	_create_pieces()


func _cube_box(size: float) ->void:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	var box: BoxMesh = BoxMesh.new()
	box.size = Vector3(size, size, size)
	mesh_instance.mesh = box
	add_child(mesh_instance)
	mesh_instance.position = Vector3.ZERO

	var material = StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color(0, 0, 1, 0.2)
	mesh_instance.material_override = material


func _fill_rotator(rotator: Node3D, cubes: int, y: float) ->void:
	var mesh_instance: MeshInstance3D
	var box: BoxMesh
	var offset: float = ((cubes * 2) - 1) / 2 
	#offset = 0
	for cube_x in cubes:
		for cube_z in cubes:
			mesh_instance = MeshInstance3D.new()
			box = BoxMesh.new()
			box.size = Vector3(1, 1, 1)
			mesh_instance.mesh = box
			mesh_instance.position = Vector3(cube_x * 2 - offset, y, cube_z * 2 - offset)
			rotator.add_child(mesh_instance)


func _create_rotator(pos: Vector3) ->void:
	var rotator: Node3D = Node3D.new()
	var area: Area3D = Area3D.new()
	var collision_shape: CollisionShape3D = CollisionShape3D.new()
	rotator.name = "ry" + str(pos.y)
	#pos.y *= 2
	rotator.position = pos
	print(rotator.name)
	area.add_child(collision_shape)
	rotator.add_child(area)
	rotators_y.add_child(rotator)


func _create_rotators(line_length: int) -> void:
	var area: Area3D
	var collision: CollisionShape3D
	var shape_x:BoxShape3D = BoxShape3D.new()
	var shape_y:BoxShape3D = BoxShape3D.new()
	var shape_z:BoxShape3D = BoxShape3D.new()

	shape_y.size = Vector3(cube_size, container_size, cube_size)
	for y in line_length:
		area = Area3D.new()
		area.position = Vector3(0, (y * container_size * 2) - offset, 0)
		area.name = "ry" + str(y)
		area.collision_mask = 2
		collision = CollisionShape3D.new()
		collision.shape = shape_y
		area.add_child(collision)
		rotators_y.add_child(area)
	
	shape_x.size = Vector3(container_size, cube_size, cube_size)
	for x in line_length:
		area = Area3D.new()
		area.position = Vector3((x * container_size * 2) - offset, 0 ,0)
		area.name = "rx" + str(x)
		area.collision_mask = 2
		collision = CollisionShape3D.new()
		collision.shape = shape_x
		area.add_child(collision)
		rotators_x.add_child(area)
	
	shape_z.size = Vector3(cube_size, cube_size, container_size)
	for z in line_length:
		area = Area3D.new()
		area.position = Vector3(0, 0, (z * container_size * 2) - offset)
		area.name = "rz" + str(z)
		area.collision_mask = 2
		collision = CollisionShape3D.new()
		collision.shape = shape_z
		area.add_child(collision)
		rotators_z.add_child(area)
		
		
func _create_containers(line_length:int) ->void:
	var area: Area3D
	var collision: CollisionShape3D
	var shape: BoxShape3D = BoxShape3D.new()
	shape.size = Vector3(container_size, container_size, container_size)
	for y in line_length:
		for x in line_length:
			for z in line_length:
				if (y == 0 || y == line_length -1) || (x == 0 || x == line_length -1) || (z == 0 || z == line_length -1):
					area = Area3D.new()
					area.position = Vector3((x * container_size * 2) - offset, (y * container_size * 2) - offset, (z * container_size * 2) - offset)
					area.collision_mask = 2
					collision = CollisionShape3D.new()
					collision.shape = shape
					area.add_child(collision)
					containers.add_child(area)


func _rotate_node(node: Area3D, axis: Vector3, degrees: int) -> void:
	_select_pieces(node)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	var target = node.rotation_degrees + axis * degrees
	tween.tween_property(node, "rotation_degrees", target, 0.5)
	tween.tween_callback(func(): _end_rotation("fin"))


func _end_rotation(text: String) ->void:
	print(text)
	_reparent_pieces()
	can_move = true
	

func _create_pieces() ->void:
	for child in containers.get_children():
		if child.get_child_count() == 1:
			var instance = piece.instantiate()
			instance.position = child.position
			add_child(instance)
			instance.reparent(child, true)


func _reparent_pieces() ->void:
	for child in containers.get_children():
		if child.get_child_count() == 0:
			var piece = child.get_overlapping_bodies()
			piece[0].reparent(child, true)


func _select_pieces(area: Area3D) ->void:
	for body in area.get_overlapping_bodies():
		body.reparent(area, true)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and can_move:
			can_move = false
			_rotate_node($RotatorsZ/rz3, Vector3.FORWARD, 90)
