extends Node3D

@onready var test_cube: MeshInstance3D = $MeshInstance3D

func _process(delta: float) -> void:
	test_cube.rotate(Vector3i.UP, 1 * delta)
